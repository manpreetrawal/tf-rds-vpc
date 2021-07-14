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
variable "name" {
    default = "gardeneur"
}
variable "rds_instance_password"{
    default = "admin@123"
}
variable "rds_mysql_version" {
     default = "5.7.33"
}
variable "rds_instance_type"{
     default = "db.t3.micro"
}
variable "rds_min_storage"{
   default = "20"
}
variable "rds_max_allocated_storage"{
   default = "200"
}
variable "rds_enable_multi_az"{
   default = false
}
