variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "mysql_sg_name" {
  default = "mysql"
}

variable "mysql_sg_tags" {
  default = {
    Component = "mysql"
  }
}

variable "backend_sg_name" {
  default = "backend"
}

variable "backend_sg_tags" {
  default = {
    Component = "backend"
  }
}

variable "frontend_sg_name" {
  default = "front"
}

variable "frontend_sg_tags" {
  default = {
    Component = "frontend"
  }
}

variable "bastion_sg_name" {
  default = "bastion"
}

variable "bastion_sg_tags" {
  default = {
    Component = "bastion"
  }
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}