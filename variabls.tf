variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}
variable "common_variables" {
  description = "Common variables for the infrastructure"
  type = map(any)
}
variable "vpc" {
  description = "VPC configuration variables"
  type = map(any)
}