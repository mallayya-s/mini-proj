resource "aws_internet_gateway" "proj_igw" {
    vpc_id = "${aws_vpc.proj_vpc.id}"
    tags = {
        Name = "project-poc-igw"
    }
}

resource "aws_route_table" "proj_rt" {
    vpc_id = "${aws_vpc.proj_vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.proj_igw.id}" 
    }
    
    tags = {
        Name = "project-poc-rt"
    }
}

resource "aws_route_table_association" "proj_rt_subnet_1"{
    subnet_id = "${aws_subnet.proj_sub1.id}"
    route_table_id = "${aws_route_table.proj_rt.id}"
}

resource "aws_route_table_association" "proj_rt_subnet_2"{
    subnet_id = "${aws_subnet.proj_sub2.id}"
    route_table_id = "${aws_route_table.proj_rt.id}"
}