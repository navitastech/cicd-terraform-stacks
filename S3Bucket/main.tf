provider "aws" {
    region     = "us-east-1"
}

module "s3bucket" {
  source = "../modules/tf_module_s3"
   bucket_name = "${var.bucket_name}"
   access_control = "private"
  
  }


  