output "scale_policy_id" {
  value = "${aws_autoscaling_policy.scale_policy.id}"
}

output "scale_policy_arn" {
 value = "${aws_autoscaling_policy.scale_policy.arn}"
}
