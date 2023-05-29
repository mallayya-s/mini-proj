resource "aws_lb" "proj_alb" {
  name               = "proj-poc-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.proj_alb_sg.id]
  subnets = [data.aws_subnet.sub_1.id, data.aws_subnet.sub_2.id]
}

resource "aws_security_group" "proj_alb_sg" {
  vpc_id = data.aws_vpc.proj_vpc.id
  name = "proj-poc-alb-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  //allowing to access application
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "proj-poc-alb-sg"
  }
}

resource "aws_lb_listener" "proj_listener" {
  load_balancer_arn = aws_lb.proj_alb.arn
  port              = "8000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proj_tg.arn
  }
}

resource "aws_lb_target_group" "proj_tg" {
  name        = "proj-poc-tg"
  target_type = "instance"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.proj_vpc.id
  
  health_check {
    enabled             = true
    interval            = 30
    path                = "/gtg"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 10
  }
}