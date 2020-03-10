resource "aws_eip" "nat_gateway_public_a" {
    vpc = true
    depends_on = [aws_internet_gateway.icash_dev]

    tags = {
        Name = "icash_dev"
    }
}

resource "aws_eip" "nat_gateway_public_c" {
    vpc = true
    depends_on = [aws_internet_gateway.icash_dev]

    tags = {
        Name = "icash_dev"
    }
}
