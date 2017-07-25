

resource "aws_launch_configuration" "launch_config" {
  name_prefix = "${var.app_name}_${var.app_env}_lc_"
  associate_public_ip_address = "${var.associate_public_ip}"
  image_id = "${var.ec2_machine_image}"
  key_name = "${var.ec2_user_login_key}"
  iam_instance_profile = "${var.ec2_iam_instance_role}"
  instance_type = "${var.ec2_instance_type}"
  security_groups = ["${split(",", var.security_groups)}"]
  user_data = "${coalesce(var.ec2_user_data_raw, file(var.ec2_user_data))}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name = "${var.app_name}-${var.app_env}-asg"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  max_size = "${var.asg_maximum_number_of_instances}"
  min_size = "${var.asg_minimum_number_of_instances}"
  desired_capacity = "${var.asg_desired_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"
  load_balancers = ["${split(",", var.load_balancer_names)}"]
  availability_zones = ["${split(",", var.availability_zones)}"]
  vpc_zone_identifier = ["${split(",", var.vpc_zone_subnets)}"]


  tag {
    key = "Name"
    value = "${var.app_name}ec2${var.app_env}"
    propagate_at_launch = true
  }
  tag {
    key = "role"
    value = "${var.app_name}_${var.app_env}"
    propagate_at_launch = true
  }

  tag {
    key = "stack"
    value = "${coalesce(var.stack_name, format("%s_%s_stack", var.app_name,  var.app_env  ))}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
