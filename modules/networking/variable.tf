variable "region" {
  description = "AWS Deployment region.."
  default = "us-west-2"
}
variable "environment" {
     description = "AWS Deployment region.."
     default = "staging"
}
variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "subnet_newbits" {
    default = 4
}
