module "ec2-vpc-1" {
  source = "./modules/ec2-vpc"

  postfix = "tf1-instance1"
  ami_id = data.aws_ami.ubuntu.id
}

module "ec2-vpc-2" {
  source = "./modules/ec2-vpc"

  postfix = "tf1-instance2"
  ami_id = data.aws_ami.ubuntu.id
}
