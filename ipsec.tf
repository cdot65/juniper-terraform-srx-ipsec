terraform {
  required_providers {
    junos-ike = {
      source  = "cdot65/junos-ike"
      version = "0.0.1"
    }
  }
}

provider "junos-ike" {
  host     = var.juniper_host_name
  port     = var.juniper_ssh_port
  sshkey   = var.juniper_ssh_key
  username = var.juniper_user_name
  password = var.juniper_user_password
}

module "ike" {
  source     = "./ike"
  providers  = { junos-ike = junos-ike }
  depends_on = [junos-ike_destroycommit.commit-main]
}

resource "junos-ike_commit" "commit-main" {
  resource_name = "commit"
  depends_on    = [module.ike]
}

resource "junos-ike_destroycommit" "commit-main" {
  resource_name = "destroycommit"
}