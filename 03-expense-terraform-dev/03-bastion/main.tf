module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-bastion"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  subnet_id              = local.public_subnet
  ami = data.aws_ami.ami_info.id

  tags =  merge (
    var.common_tags,
    var.bastion_group_tags,
    {
    Name = "${var.project_name}-${var.environment}-bastion" # expense-dev-bastion
  }
  )
}
