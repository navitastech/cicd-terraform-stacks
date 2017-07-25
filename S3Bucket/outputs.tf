
output "bucket_name" {
  value = "${module.s3bucket.bucket_name}"
}

output "bucket_arn" {
  value = "${module.s3bucket.bucket_arn}"
}
