variable "public_subnets" {
   default = [] 
}
variable "name" {
    default = "gardeneur"
}
variable "vpc_id" {
}
variable "environment" {
     description = "AWS Deployment region.."
     default = "staging"
}
variable "vpc_cidr_block"{
}
variable "security_group"{
}
