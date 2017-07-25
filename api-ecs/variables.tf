variable "aws_region" {
  description = "The AWS Region that the instances is created in"
  default = "us-east-1"
}
 
 


variable "app_env" {
	default = "dev"
}
 

variable "ecs_cluster_name" {
	default = "demo_api_ecs"
}

variable "stack_name" {
	default = ""
}


variable "ec2_user_data" {
  description = "The path to a file with user_data for the instances"
  default = "userdata.sh"
}

variable "ec2_user_data_raw" {
	description = "The raw user_data script content"
	default = ""
}
