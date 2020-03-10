resource "aws_internet_gateway" "icash_dev" {
    vpc_id = aws_vpc.icash_dev.id

    tags = {
        Name = "icash_dev"
    }
}
