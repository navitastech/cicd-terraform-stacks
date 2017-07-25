variable "aws_region" {
  description = "The AWS Region that the instances is created in"
  default = "us-east-1"
}
 

 
variable "bucket_name" {
  description = "Name of the Bucket (e.g. creditwise-logs, inform-data, etc)"
}


variable "object_lifetime" {
	description = "Number of days before the data moves to Glacier from the bucket"
  default = "60"
}

variable "access_control" {
	description = "Access control for the bucket"
  default = "private"
}

variable "bucket_policy_raw" {
	description = "raw bucket policy content"
    default = ""
}

variable "bucket_policy" {
	description = "the path to json file with bucket policy"
    default = "s3_bucket_policy.json"
}

variable "versioning" {
	description = "versioning for the bucket"
    default = "true"
}

