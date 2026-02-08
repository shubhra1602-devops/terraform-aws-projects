// we will set rules, Inbound rule - bahar se aane wala traffic
// Outbound rule = bahar jaane wala traffic
resource "aws_security_group" "nginx-sg" {
  vpc_id = aws_vpc.my_vpc.id

  //Inbound rule for HTTP
    ingress {
        from_port = 80  //port range
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

  //Outbound rule for HTTP
    egress {
        from_port = 0  //enable for all ports
        to_port = 0
        protocol = "-1"  //It is enable for all protocol
        cidr_blocks = ["0.0.0.0/0"] //enable for all IPs
    }
    tags = {
      Name = "nginx-sg"
    }

}