variable "private_subnets" {
   default = [] 
}
variable "name" {
    default = "gardeneur"
}
variable "vpc_id" {
}
variable "vpc_cidr_block"{
}
variable "rds_instance_password"{
}
variable "rds_mysql_version" {
}
variable "rds_instance_type"{
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
variable "environment" {
     description = "AWS Deployment region.."
     default = "staging"
}
