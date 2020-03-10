resource "aws_lb" "dev" {
    name = "dev"
    load_balancer_type = "application"    
    internal = false
    idle_timeout = 60
    enable_deletion_protection = false

    subnets = [
        aws_subnet.public_a.id,
        aws_subnet.public_c.id,
    ]

    access_logs {
        bucket = aws_s3_bucket.alb_log.id
        enabled = true
    }

    security_groups = [
        module.http_sg.security_group_id,
        module.https_sg.security_group_id,
        module.http_redirect_sg.security_group_id,
    ]
    
    tags = {
        Name = "icash_dev"
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.dev.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "これは[http]です"
            status_code = "200"
        }
    }
}

resource "aws_lb_listener_rule" "dev" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.dev.arn
    }

    condition {
        path_pattern {
            values = ["/*"]
        }
    }
}

output "alb_dns_name" {
    value = aws_lb.dev.dns_name
}


module "http_sg" {
    source = "./security_group"
    name = "http-sg"
    vpc_id = aws_vpc.icash_dev.id
    port = 80
    cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
    source = "./security_group"
    name = "https-sg"
    vpc_id = aws_vpc.icash_dev.id
    port = 443
    cidr_blocks = ["0.0.0.0/0"]

}

module "http_redirect_sg" {
    source = "./security_group"
    name = "http-redirect-sg"
    vpc_id = aws_vpc.icash_dev.id
    port = 8080
    cidr_blocks = ["0.0.0.0/0"]
}