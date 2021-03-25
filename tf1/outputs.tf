output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "instance1" {
  value = module.ec2-vpc-1.instance_ip_addr
}

output "instance2" {
  value = module.ec2-vpc-2.instance_ip_addr
}
