variable "aws_region" {
  default ="us-east-1"
}

variable "subnets" {
  description = "The ELB subnets"
}

variable "security_groups" {
  description = "Security Group for ec2 instances"
}
 
variable "elb_healthcheck_url" {
  description = "Health Check url"
}
 


variable "internal_elb" {
  description = "internal or external elb"
  default = "true"
}

variable "instance_port" {
  description = "instance port"
  default = "8080"
}

variable "instance_protocol" {
  description = "instance protocol"
  default = "http"
}

 

variable "app_name" {
  description = "Application Name for the stack"
}

variable "app_env" {
  description = "Application env for the stack"
}
 

variable "healthy_threshold" {
    description = "The number of checks before the instance is declared healthy."
    default = "3"
}

variable "unhealthy_threshold" {
    description = "The number of checks before the instance is declared unhealthy."
    default = "5"
}

variable "timeout" {
    description = "The length of time, in seconds, before the health check times out."
    default = "5"
}

variable "interval" {
    description = "The interval, in seconds, between health checks."
    default = "30"
}

variable "stack_name" {
  default = ""
}

variable "elb_name" {
  default = ""
}
