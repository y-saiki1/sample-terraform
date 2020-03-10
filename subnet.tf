resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.icash_dev.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-northeast-1a"

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_subnet" "public_c" {
    vpc_id = aws_vpc.icash_dev.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-northeast-1c"

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_subnet" "private_a" {
    vpc_id = aws_vpc.icash_dev.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false
    availability_zone = "ap-northeast-1a"

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_subnet" "private_c" {
    vpc_id = aws_vpc.icash_dev.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = "ap-northeast-1c"

    tags = {
        Name = "icash_dev"
    }
}