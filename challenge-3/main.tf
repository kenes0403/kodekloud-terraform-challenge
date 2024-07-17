# Create key-pair
resource "aws_key_pair" "citadel-key" {
    key_name = "citadel"
    public_key = file("/root/terraform-challenges/project-citadel/.ssh/ec2-connect-key.pub")
}

# Create aws instance with user data
resource "aws_instance" "citadel_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.citadel-key.key_name
    user_data = file("/root/terraform-challenges/project-citadel/install-nginx.sh")
}

# Create and Attach Elastic IP to aws instance
resource "aws_eip" "eip" {
    instance = aws_instance.citadel_instance.id
    vpc = true
    provisioner "local-exec" { 
        command = "echo ${self.public_dns} > /root/citadel_public_dns.txt"
    }
}

# Outputs
output "instance_id" {
  value       = aws_instance.citadel.id
  description = "description"
}

output "instance_public_ip" {
    value = aws_eip.eip.public_ip
    description = "Public IP"
}
