resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }

}
resource "aws_subnet" "public_Subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
        Name = "${var.vpc_name}-public"
    }

}
resource "aws_subnet" "private_Subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
        Name = "${var.vpc_name}-private"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-igw"
    }
}
resource "aws_eip" "eipnat" {

  tags = {  
    Name = "${var.vpc_name}-eipnat"
  }
}
resource "aws_nat_gateway" "nat" {
    count = (length(var.public_subnet_cidrs) > 0) ? 1 : 0
    allocation_id = aws_eip.eipnat.id
    subnet_id    = aws_subnet.public_Subnet[count.index].id
    tags = {
        Name = "${var.vpc_name}-nat"
    }
}
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "${var.vpc_name}-private-rt"
    }
}
resource "aws_route_table_association" "public_rta" {
    count = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.public_Subnet[count.index].id
    route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private_rta" {
    count = length(var.private_subnet_cidrs)
    subnet_id      = aws_subnet.private_Subnet[count.index].id
    route_table_id = aws_route_table.private_rt.id
}