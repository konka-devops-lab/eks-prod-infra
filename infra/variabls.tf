variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}
variable "common_vars" {}
variable "vpc" {}
variable "sg" {}
variable "lb_acm" {}
variable "external_alb" {}