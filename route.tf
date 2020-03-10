resource "aws_route" "public" {
    route_table_id = aws_route_table.public.id
    gateway_id = aws_internet_gateway.icash_dev.id
    destination_cidr_block = "0.0.0.0/0"

    # tags = {
    #     Name = "icash_dev"
    # }
}

resource "aws_route" "private_a" {
    route_table_id = aws_route_table.private_a.id
    nat_gateway_id = aws_nat_gateway.public_a.id
    destination_cidr_block = "0.0.0.0/0"

    # tags = {
    #     Name = "icash_dev"
    # }
}

resource "aws_route" "private_c" {
    route_table_id = aws_route_table.private_c.id
    nat_gateway_id = aws_nat_gateway.public_c.id
    destination_cidr_block = "0.0.0.0/0"

    # tags = {
    #     Name = "icash_dev"
    # }
}
