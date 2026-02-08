output "aws_instance_public_ip" {  //Jab bhi AWS banta hai mujhe terminal me Public IP chaiye
  value = aws_instance.myserver.public_ip // myserver ki Public IP show kar do
}