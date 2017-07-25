variable "aws_region" {
  description = "The AWS Region that the instances is created in"
  default = "us-east-1"
}

variable "app_env" {
	default = "dev"
}

variable "web-min-instances" {
   default = "1"

}

variable "web-max-instances" {
   default = "1"
}

variable "web-desired-instances" {
   default = "1"
}

variable "app_name" {
	default = "demo"
}


variable "stack_name" {
	default = ""
}


variable "elb_name" {
	default = ""
}


variable "timestamp" {
	default = "notimestamp"
}
