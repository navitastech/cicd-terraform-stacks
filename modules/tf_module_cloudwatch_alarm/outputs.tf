output "alarm_id" {
  value = "${aws_cloudwatch_metric_alarm.main_alarm.id}"
}