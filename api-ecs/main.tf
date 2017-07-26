provider "aws" {
    region     = "us-east-1"
}


resource "aws_ecs_cluster" "ecscluster" {
  name = "${var.ecs_cluster_name}_${var.app_env}"
}



resource "aws_launch_configuration" "launch_config" {
  name_prefix = "${var.ecs_cluster_name}_${var.app_env}_lc_"
  associate_public_ip_address = "false"
  image_id = "ami-04351e12"
  key_name = "NavitasDevOps"
  iam_instance_profile = "ecs-instance-role"
  instance_type = "t2.large"
  security_groups = ["sg-129ead63"]
  user_data = "${template_file.user_data.rendered}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name = "${var.ecs_cluster_name}_${var.app_env}_asg"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  max_size = "2"
  min_size = "1"
  desired_capacity = "1"
  health_check_grace_period = "1800"
  health_check_type = "EC2"
  availability_zones = ["us-east-1a"]
  vpc_zone_identifier = ["subnet-9e871fb2"]


  tag {
    key = "Name"
    value = "${var.ecs_cluster_name}_ec2${var.app_env}"
    propagate_at_launch = true
  }
  tag {
    key = "role"
    value = "${var.ecs_cluster_name}_${var.app_env}"
    propagate_at_launch = true
  }

  tag {
    key = "stack"
    value = "${coalesce(var.stack_name, format("%s_%s_stack", var.ecs_cluster_name,  var.app_env  ))}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "template_file" "user_data" {
	template = "${file("${path.module}/userdata.sh")}"

  vars {
    ecs_cluster_name = "${var.ecs_cluster_name}"
    app_env = "${var.app_env}"

  }
}


resource "aws_ecs_service" "demo_api_service" {
    name = "demo_api_service"
    cluster = "${aws_ecs_cluster.ecscluster.id}"
    task_definition = "${aws_ecs_task_definition.demo_api_task.arn}"
    desired_count = 1
    iam_role = "arn:aws:iam::550522744793:role/ecsServiceRole"
    
    load_balancer {
        elb_name = "${module.demo_service_elb.elb_id}"
        container_name = "demo-api-service"
        container_port = 8080
    }
}


resource "aws_ecs_task_definition" "demo_api_task" {
    family = "demo_api_service"
    container_definitions = "${file("task-definitions/demo-api-task.json")}"


}


module "demo_service_elb" {
  source = "../modules/tf_module_elb"
  elb_name="demo-service-${var.app_env}-elb"
  subnets = "subnet-11b9213d"
  security_groups = "sg-85240af4"
  elb_healthcheck_url = "HTTP:8080/index.html"
  instance_port = 8080
  internal_elb = "false"
  unhealthy_threshold = "10"
  instance_protocol = "http"
  app_name = "demo_service"
  app_env = "${var.app_env}"
  stack_name="${var.stack_name}"
  aws_region = "${var.aws_region}"
  }





