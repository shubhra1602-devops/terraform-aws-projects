//1. EC2 instance banne ke baad uske andar jakar humme Nginx web server ko setup karna hai.
//2. Let's suppose Nginx web server hamra setup ho jata hai toh usko browser se access kaise karenge?
//3. Humme Security Group banana padega jaha hum allow kar sake HTTP ka access.
//4. Jo EC2 instance humlog banaenge ussi EC2 instance ke andar jakar Nginx ko install karna.

//nginx install kaise karenge ec2 ke andar -> User data

resource "aws_instance" "nginxserver" {
  ami                       = "ami-073130f74f5ffb161"
  instance_type             = "t3.micro"
  subnet_id                 = aws_subnet.public-subnet.id
  vpc_security_group_ids    = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true //browser se accessible hone ke liye ek public IP honi chaiye

//Install Nginx inside EC2 
  user_data = <<-EOF
               #!/bin/bash
               apt update -y
               apt install nginx -y
               systemctlenable nginx
               systemctl start nginx 
               EOF
//Nginx setup ho gaya and ab run bhi ho jaega but humlog isko access kaise karenge
//Access karne ke liye humme Security Group banana padega

  tags = {
    Name = "NginxServer"
  }
}