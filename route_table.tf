resource "aws_route_table" "public" {
    vpc_id = aws_vpc.icash_dev.id

    tags = {
        Name = "icash_dev"
    }
    
}

resource "aws_route_table" "private_a" {
    vpc_id = aws_vpc.icash_dev.id

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_route_table" "private_c" {
    vpc_id = aws_vpc.icash_dev.id

    tags = {
        Name = "icash_dev"
    }
}