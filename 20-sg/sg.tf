module "mysql_sg" {
  source = "../../terraform-aws-modules/aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = local.vpc_id
  sg_name = var.sg_name
  sg_tags = var.mysql_sg_tags
  common_tags = var.common_tags
}