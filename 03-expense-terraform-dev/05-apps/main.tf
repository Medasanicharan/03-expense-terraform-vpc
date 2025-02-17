module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-backend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  subnet_id              = local.private_subnet_id
  ami = data.aws_ami.ami_info.id

  tags =  merge (
    var.common_tags,
    {
    Name = "${var.project_name}-${var.environment}-backend" # expense-dev-bastion
  }
  )
}


module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-frontend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
  subnet_id              = local.public_subnet_id
  ami = data.aws_ami.ami_info.id

  tags =  merge (
    var.common_tags,
    {
    Name = "${var.project_name}-${var.environment}-frontend" # expense-dev-bastion
  }
  )
}

module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-ansible"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible_sg_id.value]
  subnet_id              = local.public_subnet_id
  user_data = file("expense.sh")
  ami = data.aws_ami.ami_info.id

  tags =  merge (
    var.common_tags,
    {
    Name = "${var.project_name}-${var.environment}-ansible" # expense-dev-bastion
  }
  )
}

# create R53 recoed for RDS end point

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "backend"
      type    = "A"
      ttl     = 1
       records = [
        module.backend.private_ip
      ]
    },

    {
      name    = "frontend"
      type    = "A"
      ttl     = 1
       records = [
        module.frontend.private_ip
      ]
    },

    {
      name    = ""
      type    = "A"
      ttl     = 1
       records = [
        module.frontend.public_ip
      ]
    },
  ]
}