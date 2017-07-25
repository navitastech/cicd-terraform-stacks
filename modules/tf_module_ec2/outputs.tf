output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}

output "ec2_instance_ip" {
  value = "${aws_instance.ec2_instance.private_ip}"
}

output "ec2_instance_dns" {
	value = "${aws_instance.ec2_instance.private_dns}"
}
