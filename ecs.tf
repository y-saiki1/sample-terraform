# InvalidParameterException: Unable to assume the service linked role
# この問題について
# clusterと同時にserviceを作成すると自動で下記ロールが作成されるが、タイムラグで作成されていない判定をされる模様
# なので一度applyを実行→エラーで落ちる→もう一度実行すると通るということが起こる模様
# 対応策としては自動で作られるロールを先に作成しておく
# https://nekopunch.hatenablog.com/entry/2018/09/01/122525

resource "aws_iam_service_linked_role" "ecs" {
  aws_service_name = "ecs.amazonaws.com"
}

resource "aws_ecs_cluster" "dev" {
    name = "dev"
}

resource "aws_ecs_task_definition" "dev" {
    family = "dev"
    cpu = "256"
    memory = "512"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    container_definitions = file("./container_definitions.json")
}

resource "aws_ecs_service" "dev" {
    name = "dev"
    cluster = aws_ecs_cluster.dev.arn
    task_definition = aws_ecs_task_definition.dev.arn
    desired_count = 2
    launch_type = "FARGATE"
    platform_version = "1.3.0"
    health_check_grace_period_seconds = 60

    network_configuration {
        assign_public_ip = false
        security_groups = [module.nginx_sg.security_group_id]
        
        subnets = [
            aws_subnet.private_a.id,
            aws_subnet.private_c.id,
        ]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.dev.arn
        container_name = "dev"
        container_port = 80
    }

    lifecycle {
        ignore_changes = [task_definition]
    }
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
    arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
    source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

    statement {
        effect = "Allow"
        actions = ["ssm:GetParameters", "kms:Decrypt"]
        resources = ["*"]
    }
}

module "ecs_task_excution_role" {
    source = "./iam_role"
    name = "ecs-task-execution"
    identifier = "ecs-tasks.amazonaws.com"
    policy = data.aws_iam_policy_document.ecs_task_execution.json
}


module "nginx_sg" {
    source = "./security_group"
    name = "nignx-sg"
    vpc_id = aws_vpc.icash_dev.id
    port = 80
    cidr_blocks = [aws_vpc.icash_dev.cidr_block]
}
