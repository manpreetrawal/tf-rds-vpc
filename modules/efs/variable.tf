variable "region" {
  description = "AWS Deployment region.."
  default = "us-west-2"
}
variable "environment" {
     description = "AWS Deployment region.."
     default = "staging"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
    default = "10.0.0.0/24"
}
variable "private_subnets_cidr" {
    default = "10.0.1.0/24"
}
variable "availability_zones" {
    default = "us-west-2a"
}
variable "name" {
    default = "gardeneur"
}
variable "security_group" {
}
variable "private_subnet" {
}

