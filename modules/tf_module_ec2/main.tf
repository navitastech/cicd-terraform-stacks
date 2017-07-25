
resource "aws_instance" "ec2_instance" {
  ami = "${var.ec2_machine_image}"
  count = "${var.number_of_instances}"
  instance_type = "${var.ec2_instance_type}"
  key_name = "${var.ec2_user_login_key}"
  iam_instance_profile="${var.ec2_iam_instance_role}"
  user_data = "${coalesce(var.ec2_user_data_raw, file(var.ec2_user_data))}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${split(",", var.security_groups)}"]

  tags {
    Name = "${var.app_name}ec2${var.app_env}"
    stack = "${coalesce(var.stack_name, format("%s_%s_stack", var.app_name,var.app_env  ))}"
    envtype = "${var.app_env}"
   }
}
