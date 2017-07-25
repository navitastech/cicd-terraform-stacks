variable "aws_region" {
  description = "The AWS Region that the instances is created in"
  default ="us-east-1"
}

variable "app_name" {
  description = "Application Name for the stack"
}

variable "app_env" {
  description = "Application env for the stack"
}

variable "scale_type" {
  description = "Scale type up or down"
}

variable "scale_adjustment" {
  description = "Scale adjustement"
}

variable "asg_name" {
  description = "Auto Scaling group name"
}
