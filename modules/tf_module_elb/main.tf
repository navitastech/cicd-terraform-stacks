
resource "aws_elb" "elb" {
  name = "${coalesce(var.elb_name, format("%s-%s-elb", var.app_name, var.app_env  ))}"
  internal = "${var.internal_elb}"
  subnets = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.security_groups)}"]
  connection_draining = true
  connection_draining_timeout = 120
  cross_zone_load_balancing = true

  listener {
    instance_port = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    interval            = "${var.interval}"
    target = "${var.elb_healthcheck_url}"
  }

  tags {
    Name = "${var.app_name}_${var.app_env}_elb"
    stack = "${coalesce(var.stack_name, format("%s_%s_stack", var.app_name, var.app_env  ))}"
    envtype = "${var.app_env}"
   }
}
