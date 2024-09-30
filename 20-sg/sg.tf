module "mysql_sg" {
  #source = "https://github.com/Anilgitg/terraform-aws-modules.git//aws-security-group?ref=main"
  source = "../../terraform-aws-modules/aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = local.vpc_id
  sg_name = var.mysql_sg_name
  sg_tags = var.mysql_sg_tags
  common_tags = var.common_tags
}

module "backend_sg" {
  #source = "https://github.com/Anilgitg/terraform-aws-modules.git//aws-security-group?ref=main"
  source = "../../terraform-aws-modules/aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = local.vpc_id
  sg_name = var.backend_sg_name
  sg_tags = var.backend_sg_tags
  common_tags = var.common_tags
}

module "frontend_sg" {
  #source = "https://github.com/Anilgitg/terraform-aws-modules.git//aws-security-group?ref=main"
  source = "../../terraform-aws-modules/aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = local.vpc_id
  sg_name = var.frontend_sg_name
  sg_tags = var.frontend_sg_tags
  common_tags = var.common_tags
}

module "bastion_sg" {
  #source = "https://github.com/Anilgitg/terraform-aws-modules.git//aws-security-group?ref=main"
  source = "../../terraform-aws-modules/aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = local.vpc_id
  sg_name = var.bastion_sg_name
  sg_tags = var.bastion_sg_tags
  common_tags = var.common_tags
}

#creating a ingress rule in mysql security group
#mysql is allowing the connection on 3306 from the instances which are attached to backend security group
resource "aws_security_group_rule" "mysql_backend" {
  type = "ingress"
  source_security_group_id = module.backend_sg.id
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = module.mysql_sg.id
}

#creating a ingress rule in backend security group
#backend is allowing the connection on 8080 from the instances which are attached to frontend security group
resource "aws_security_group_rule" "backend_frontend" {
  type = "ingress"
  source_security_group_id = module.frontend_sg.id
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  security_group_id = module.backend_sg.id
}

#creating a ingress rule in frontend security group
#frontend is allowing the connections from internet
resource "aws_security_group_rule" "frontend_public" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_sg.id
}

#creating a ingress rule in bastion security group
resource "aws_security_group_rule" "mysql_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}

#creating a ingress rule in bastion security group
resource "aws_security_group_rule" "backend_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.backend_sg.id
}

#creating a ingress rule in bastion security group
resource "aws_security_group_rule" "frontend_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.frontend_sg.id
}