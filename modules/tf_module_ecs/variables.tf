variable "aws_region" {
  description = "The AWS Region that the instances is created in"
  default ="us-east-1"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "default"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "launch_config_name" {
  description = "The launch configuration name"
  default = "app_lc"
}

variable "vpc_zone_subnets" {
  description = "The VPC subnet the instance(s) will go in"

}

variable "asg_maximum_number_of_instances" {
  description = "Maximum number of ec2 instances to run"
  default = "1"
}

variable "asg_minimum_number_of_instances" {
  description = "Minimum number of ec2 instances to run"
  default = "1"
}

variable "asg_desired_number_of_instances" {
  description = "Desired number of ec2 instances to run"
  default = "1"
}

variable "health_check_grace_period" {
  description = "Health Check grace period for elb"
  default = "600"
}

variable "health_check_type" {
  description = "Health Check type"
  default = "ELB"
}

variable "load_balancer_names" {
  description = "Load Balancer that should atttached to this ASG"
}

variable "availability_zones" {
  description = "Availability Zones foe ec2 instances to launch"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type that is created"
  default = "t2.medium"
}

variable "ec2_user_login_key" {
  description = "The Pem key that need to"

}

variable "ec2_iam_instance_role" {

}

variable "associate_public_ip" {
  default = "false"
}

variable "ec2_machine_image" {
  description = "The AMI to use"

}

variable "security_groups" {
  description = "Security Group for ec2 instances"
}

variable "ec2_user_data" {
  description = "The path to a file with user_data for the instances"
  default = "ec2-user-data.sh"
}

variable "ec2_user_data_raw" {
	description = "The raw user_data script content"
	default = ""
}



variable "app_name" {
  description = "Application Name for the stack"
}

variable "app_env" {
  description = "Application env for the stack"
}

variable "stack_name" {
  default = ""
}
variable "asg_name" {
  default = ""
}
