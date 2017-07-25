provider "aws" {
    region     = "us-east-1"
}


module "web_elb" {
  source = "../modules/tf_module_elb"
  elb_name="demo-${var.app_env}-web"
  subnets = "subnet-11b9213d"
  security_groups = "sg-85240af4"
  elb_healthcheck_url = "HTTP:80/robots.txt"
  instance_port = 80
  internal_elb = "false"
  unhealthy_threshold = "10"
  instance_protocol = "http"
  app_name = "demo"
  app_env = "${var.app_env}"
  stack_name="${var.stack_name}"
  aws_region = "${var.aws_region}"
  }

module "web_asg" {
  source = "../modules/tf_module_asg"
  asg_name = "demo_web_${var.stack_name}"
  load_balancer_names =  "${module.web_elb.elb_name}"
  availability_zones = "us-east-1a"
  vpc_zone_subnets = "subnet-9e871fb2"
  security_groups = "sg-d75c72a6"
  ec2_user_data = "userdata.sh"
  ec2_iam_instance_role = "DevOpsAdminRole"
  ec2_user_login_key = "NavitasDevOps"
  app_name = "demo_web"
  app_env = "${var.app_env}"
  health_check_grace_period = "1200"
  ec2_instance_type = "t2.small"
  ec2_machine_image = "ami-a4c7edb2"
  asg_maximum_number_of_instances = "${var.web-max-instances}"
  asg_minimum_number_of_instances = "${var.web-min-instances}"
  asg_desired_number_of_instances = "${var.web-desired-instances}"
  stack_name="${var.stack_name}"
  aws_region = "${var.aws_region}"
}

module "web_asg_scale_up" {
  source = "../modules/tf_module_autoscale_policy"
  app_name = "${var.app_name}"
  app_env = "${var.app_env}"
  scale_type ="up"
  scale_adjustment = "1"
  asg_name = "${module.web_asg.asg_id}"
  aws_region = "${var.aws_region}"
}

module "web_asg_scale_down" {
  source = "../modules/tf_module_autoscale_policy"
  app_name = "${var.app_name}"
  app_env = "${var.app_env}"
  scale_type ="down"
  scale_adjustment = "-1"
  asg_name = "${module.web_asg.asg_id}"
  aws_region = "${var.aws_region}"
}


module "web_cpu_high_alarm" {
  source = "../modules/tf_module_cloudwatch_alarm"
  is_create_resource = "0"
  app_name = "${var.app_name}"
  app_env = "${var.app_env}"
  alarm_type  = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "3"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "65"
  autoscaling_group_name = "${module.web_asg.asg_name}"
  alarm_description ="scale up if CPU utlization is > 65% over 3 minutes"
  alarm_actions = "${module.web_asg_scale_up.scale_policy_arn}"
  aws_region = "${var.aws_region}"
}

module "web_cpu_low_alarm" {
  source = "../modules/tf_module_cloudwatch_alarm"
 is_create_resource = "0"
  app_name = "${var.app_name}"
  app_env = "${var.app_env}"
  alarm_type  = "cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "5"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "35"
  autoscaling_group_name = "${module.web_asg.asg_name}"
  alarm_description ="scale down if CPU utlization is <= 35% over 5 minutes"
  alarm_actions = "${module.web_asg_scale_down.scale_policy_arn}"
  aws_region = "${var.aws_region}"

}
