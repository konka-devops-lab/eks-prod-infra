variable "common_variables" {
  description = "Common variables for the infrastructure"
  type = map(any)
}
variable "vpc" {
  description = "VPC configuration variables"
  type = map(any)
}