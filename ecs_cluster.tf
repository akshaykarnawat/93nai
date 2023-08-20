module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = local.ecs_cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = local.ecs_cluster_cloud_watch_log_group_name
      }
    }
  }

  services = {
    container_services = {
      cpu    = local.ecs_cluster_cpu_capacity
      memory = local.ecs_cluster_memory_capacity

      container_definitions = {

        ecs_genai_container = {
          cpu       = 256
          memory    = 512
          essential = true
          image     = "public.ecr.aws/aws-containers/ecsdemo-frontend:776fd50"
          port_mappings = [
            {
              name          = "ecs-service-port"
              containerPort = 8080
              hostPort      = 8080
              protocol      = "tcp"
            }
          ]

          enable_cloudwatch_logging = true
          log_configuration = {
            logDriver = "awslogs"
            options = {
              awslogs-group         = local.ecs_cluster_cloud_watch_log_group_name
              awslogs-region        = local.aws_region
              awslogs-stream-prefix = "ecs"
            }
          }
        }
      }

      service_connect_configuration = {
        namespace = "ecs-genai-services"
        service = {
          client_alias = {
            port     = 8080
            dns_name = "ecs-genai-service"
          }
          port_name      = "ecs-service-port"
          discovery_name = "ecs-genai-service"
        }
      }

    #   load_balancer = {
    #     service = {
    #       target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4"
    #       container_name   = "ecs_genai_container"
    #       container_port   = 8080
    #     }
    #   }

      subnet_ids = data.aws_subnets.private.ids
      security_group_rules = {
        alb_ingress_3000 = {
          type        = "ingress"
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          description = "Service port"
          cidr_blocks = [local.all_cidr_block]
          #   source_security_group_id = "sg-12345678"
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = [local.all_cidr_block]
        }
      }
    }
  }

  tags = {
    Environment = local.environment
    Project     = local.project
  }
}