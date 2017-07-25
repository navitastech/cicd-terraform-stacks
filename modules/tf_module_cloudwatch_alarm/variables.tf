variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  description = "Application Name for the stack"
}

variable "app_env" {
  description = "Application env for the stack"
}


variable "alarm_type" {
  description = "ELB/EC2/ASG"
}

variable "comparison_operator" {
  description = "he arithmetic operation to use when comparing the specified Statistic and Threshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  description = "he name for the alarm's associated metric."
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric. "
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
}
variable "threshold" {
  description = "The value against which the specified statistic is compared."
}

variable "alarm_description" {
  description = "Alarm Description"
}

variable "autoscaling_group_name" {
  description = "Auto Scaling group name"
}

variable "alarm_actions" {
  description = "Alarm Actions"

}

variable "unit" {
  description = "Alarm units"
  default = "Bytes"

}

variable "is_create_resource" {
  default = "1"
  description = "Utilizes the resource meta-parameter 'count' to determine if this resource should be created or not.  To skip creation, set this value to 0."
}
