variable project_name {
    type = string
    default = "expense"
}

variable environment {
    type = string
    default = "dev"
}

variable common_tags {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Tearrform = "true"
        }
}

variable db_sg_decription {
    type = string
    default = "SG for DB MySQL instances"
}


variable backend_sg_decription {
    type = string
    default = "SG for backend instances"
}


variable frontend_sg_decription {
    type = string
    default = "SG for frontend instances"
}

variable bastion_sg_decription {
    type = string
    default = "SG for Bastion instances"
}

variable ansible_sg_decription {
    type = string
    default = "SG for Ansible instances"
}

