resource "aws_nat_gateway" "public_a" {
    allocation_id = aws_eip.nat_gateway_public_a.id
    subnet_id = aws_subnet.public_a.id
    depends_on = [aws_internet_gateway.icash_dev]

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_nat_gateway" "public_c" {
    allocation_id = aws_eip.nat_gateway_public_c.id
    subnet_id = aws_subnet.public_c.id
    depends_on = [aws_internet_gateway.icash_dev]

    tags = {
        Name = "icash_dev"
    }
}
