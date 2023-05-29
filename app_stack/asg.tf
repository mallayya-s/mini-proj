resource "aws_autoscaling_group" "proj_asg" {
  name                      = "proj-poc-asg"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  launch_configuration      = aws_launch_configuration.proj_lc.name
  vpc_zone_identifier       = [data.aws_subnet.sub_1.id, data.aws_subnet.sub_2.id]
  target_group_arns         = [aws_lb_target_group.proj_tg.arn]

  tags = [
    {
      key                 = "Name"
      value               = "proj-poc-instance"
      propagate_at_launch = "true"
    }
  ]
}

resource "aws_launch_configuration" "proj_lc" {
  name            = "proj-poc-launch-configuration"
  image_id        = data.aws_ami.app.id
  user_data       = data.template_file.userdata.rendered
  instance_type   = "t2.micro"
  key_name        = data.aws_key_pair.proj_key.key_name
  iam_instance_profile = aws_iam_instance_profile.proj_instance_profile.name
  security_groups = ["${aws_security_group.proj_sg.id}"]
}