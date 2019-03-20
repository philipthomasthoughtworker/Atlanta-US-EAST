resource "aws_vpc" "vpc-us-east-1-d-atlanta-beach" {
    cidr_block                          = "182.168.0.0/16"
    instance_tenancy                    = "default"
    assign_generated_ipv6_cidr_block    = true

    tags = {
        Name                            = "vpc-us-east-1-d-atlanta-beach"
        HomeOffice                      = "Atlanta"
        Maintainer                      = "Philip Thomas <philip.thomas@thoughtworks.com>"
        Project                         = "Training Project"
    }
}

resource "aws_subnet" "subnet-atlanta-beach-ci-cd" {
    vpc_id                              = "${aws_vpc.vpc-us-east-1-d-atlanta-beach.id}"
    cidr_block                          = "182.168.1.0/24"
    availability_zone                   = "us-east-1a"

    tags = {
        Name                            = "subnet-atlanta-beach-ci-cd"
    }
}

resource "aws_subnet" "subnet-atlanta-beach-web-app" {
    vpc_id                              = "${aws_vpc.vpc-us-east-1-d-atlanta-beach.id}"
    cidr_block                          = "182.168.2.0/24"
    availability_zone                   = "us-east-1a"

    tags = {
        Name                            = "subnet-atlanta-beach-web-app"
    }
}

resource "aws_subnet" "subnet-atlanta-beach-web-api" {
    vpc_id                              = "${aws_vpc.vpc-us-east-1-d-atlanta-beach.id}"
    cidr_block                          = "182.168.3.0/24"
    availability_zone                   = "us-east-1a"

    tags = {
        Name                            = "subnet-atlanta-beach-web-api"
    }
}

resource "aws_subnet" "subnet-atlanta-beach-datastore" {
    vpc_id                              = "${aws_vpc.vpc-us-east-1-d-atlanta-beach.id}"
    cidr_block                          = "182.168.1.0/24"
    availability_zone                   = "us-east-1a"

    tags = {
        Name                            = "subnet-atlanta-beach-datastore"
    }
}

resource "aws_internet_gateway" "igw-atlanta-beach" {
    vpc_id                              = "${aws_vpc.vpc-us-east-1-d-atlanta-beach.id}"

    tags = {
        Name                            = "igw-atlanta-beach"
    }
}

resource "aws_nat_gateway" "ngw-atlanta-beach-datastore" {
    allocation_id                       = "${aws_eip.nat.id}"
    subnet_id                           = "${aws_subnet.subnet-atlanta-beach-datastore.id}"
    depends_on                          = "aws_internet_gateway.igw-atlanta-beach"

    tags = {
        Name                            = "ngw-atlanta-beach-datastore"
    }
}

resource "aws_nat_gateway" "ngw-atlanta-beach-web-api" {
    allocation_id                       = "${aws_eip.nat.id}"
    subnet_id                           = "${aws_subnet.subnet-atlanta-beach-web-api.id}"
    depends_on                          = "aws_internet_gateway.igw-atlanta-beach"

    tags = {
        Name                            = "ngw-atlanta-beach-web-api"
    }
}