provider "aws" {
    region     = "us-east-1"
}


resource "aws_ecs_cluster" "ecscluster" {
  name = "${var.ecs_cluster_name}_${var.app_env}"
}



resource "aws_launch_configuration" "launch_config" {
  name_prefix = "${var.ecs_cluster_name}_${var.app_env}_lc_"
  associate_public_ip_address = "false"
  image_id = "ami-04351e12"
  key_name = "NavitasDevOps"
  iam_instance_profile = "ecs-instance-role"
  instance_type = "t2.large"
  security_groups = ["sg-129ead63"]
  user_data = "${coalesce(var.ec2_user_data_raw, file(var.ec2_user_data))}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name = "${var.ecs_cluster_name}_${var.app_env}_asg"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  max_size = "2"
  min_size = "1"
  desired_capacity = "1"
  health_check_grace_period = "1800"
  health_check_type = "EC2"
  availability_zones = ["us-east-1a"]
  vpc_zone_identifier = ["subnet-9e871fb2"]


  tag {
    key = "Name"
    value = "${var.ecs_cluster_name}_ec2${var.app_env}"
    propagate_at_launch = true
  }
  tag {
    key = "role"
    value = "${var.ecs_cluster_name}_${var.app_env}"
    propagate_at_launch = true
  }

  tag {
    key = "stack"
    value = "${coalesce(var.stack_name, format("%s_%s_stack", var.ecs_cluster_name,  var.app_env  ))}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

