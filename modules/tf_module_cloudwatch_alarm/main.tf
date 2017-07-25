provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_cloudwatch_metric_alarm" "main_alarm" {
    count = "${var.is_create_resource}"
    alarm_name = "${var.autoscaling_group_name}_${var.alarm_type}_alarm"
    comparison_operator = "${var.comparison_operator}"
    evaluation_periods = "${var.evaluation_periods}"
    metric_name = "${var.metric_name}"
    namespace = "${var.namespace}"
    period = "${var.period}"
    statistic = "${var.statistic}"
    threshold = "${var.threshold}"
    dimensions {
        AutoScalingGroupName = "${var.autoscaling_group_name}"
    }
    alarm_description = "${var.alarm_description}"
    alarm_actions = ["${split(",",var.alarm_actions)}"]

}
