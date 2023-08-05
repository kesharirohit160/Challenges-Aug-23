
#Security group for Application alb
resource "aws_security_group" "sg_alb-app" {
  name        = "sg_alb-app"
  description = "sg_alb-app"
  vpc_id      = aws_vpc.three-tier.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      var.vpc_cidr
    ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
      Name = "sg_alb-app"
    }

}


# Create the Application Load Balancer
resource "aws_lb" "alb_external" {
  name               = "alb-external"
  internal           = false  # Set to true if you want an internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb-app.id]
  subnets            = [aws_subnet.public1.id,aws_subnet.public2.id]

  tags = {
    Name = "Application Load balancer"
  }
}

# Create a target group for the ALB
resource "aws_lb_target_group" "tg-external" {
  name     = "tg-external"
  port     = 80  # The port your application listens for this I used HTTP only not https
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier.id
  tags = {
    Name = "Target Group external"
  }
}


# Attach the EC2 instances (app servers 1 ) to the target group
resource "aws_lb_target_group_attachment" "app1_ec2" {
  target_group_arn = aws_lb_target_group.tg-external.arn
  target_id        = aws_instance.app1.id
  port             = 80  # The port your application listens on
}

# Attach the EC2 instances (app servers 2) to the target group
resource "aws_lb_target_group_attachment" "app2_ec2" {
  target_group_arn = aws_lb_target_group.tg-external.arn
  target_id        = aws_instance.app2.id
  port             = 80  # The port your application listens on
}

# Create the ALB listener to forward traffic to the target group
resource "aws_lb_listener" "ls_external" {
  load_balancer_arn = aws_lb.alb_external.arn
  port              = "80" # The port your application listens on
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-external.arn
  }
}

