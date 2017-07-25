
resource "aws_s3_bucket" "s3bucket" {
  bucket = "${var.bucket_name}"
  acl = "${var.access_control}"

  #policy = "${coalesce(var.bucket_policy_raw, file(var.bucket_policy))}"

  versioning {
       enabled = true
  }

  lifecycle_rule {
      id = "log"
      prefix = "log/"
      enabled = true
      expiration {
        days = "${var.object_lifetime}"
      }
  }

}
