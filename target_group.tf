resource "aws_lb_target_group" "dev" {
    name = "dev"
    target_type = "ip"
    vpc_id = aws_vpc.icash_dev.id
    port = 80
    protocol = "HTTP"
    deregistration_delay = 300

    health_check {
        path = "/"
        healthy_threshold = 5
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
        matcher = 200
        port = "traffic-port"
        protocol = "HTTP"
    }

    depends_on = [aws_lb.dev]

    tags = {
        Name = "icash_dev"
    }
}