
resource "aws_autoscaling_policy" "scale_policy" {
  name = "${var.app_name}_${var.app_env}_scale_${var.scale_type}"
  scaling_adjustment = "${var.scale_adjustment}"
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${var.asg_name}"
}
