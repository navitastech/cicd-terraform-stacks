output "asg_id" {
  value = "${aws_autoscaling_group.main_asg.id}"
}

output "asg_name" {
 value = "${aws_autoscaling_group.main_asg.name}"
}

output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id} ${aws_launch_configuration.launch_config.name}"
}
