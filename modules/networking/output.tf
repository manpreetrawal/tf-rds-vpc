output "public_subnets_cidr" {
  value = local.public_subnets_cidr
}
output "private_subnets_cidr" {
  value = local.private_subnets_cidr
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "availability_zones" {
  value = local.availability_zones
}
output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}
output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}
output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}
output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}
