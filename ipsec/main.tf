terraform {
  required_providers {
    junos-ike = {
      source  = "cdot65/junos-ike"
      version = "0.0.1"
    }
  }
}

// IKE gateways
resource "junos-ike_SecurityIkeGatewayName" "ike_gateway_name" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_gateway_name
}

resource "junos-ike_SecurityIkeGatewayAddress" "ike_gateway_address" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_gateway_name
  address       = "56.0.0.1"
}

resource "junos-ike_SecurityIkeGatewayIke__Policy" "ike_gateway_policy" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_gateway_name
  ike__policy   = var.ike_policy_name
}

resource "junos-ike_SecurityIkeGatewayExternal__Interface" "ike_gateway_ext_iface" {
  resource_name       = var.ike_apply_group_name
  name                = var.ike_gateway_name
  external__interface = "ge-0/0/0.0"
}

// IKE proposals
resource "junos-ike_SecurityIkeProposalName" "ike_proposal_name" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_proposal_name
}

resource "junos-ike_SecurityIkeProposalAuthentication__Algorithm" "ike_proposal_auth_alg" {
  resource_name             = var.ike_apply_group_name
  name                      = var.ike_proposal_name
  authentication__algorithm = "sha-256"
}

resource "junos-ike_SecurityIkeProposalAuthentication__Method" "ike_proposal_auth_method" {
  resource_name          = var.ike_apply_group_name
  name                   = var.ike_proposal_name
  authentication__method = "pre-shared-keys"
}

resource "junos-ike_SecurityIkeProposalDescription" "ike_proposal_description" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_proposal_name
  description   = "DH14-aes-128-sha-256"
}

resource "junos-ike_SecurityIkeProposalDh__Group" "ike_proposal_dhgroup" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_proposal_name
  dh__group     = "group14"
}

resource "junos-ike_SecurityIkeProposalEncryption__Algorithm" "ike_proposal_enc_alg" {
  resource_name         = var.ike_apply_group_name
  name                  = var.ike_proposal_name
  encryption__algorithm = "aes-128-cbc"
}

resource "junos-ike_SecurityIkeProposalLifetime__Seconds" "ike_proposal_lifetime" {
  resource_name     = var.ike_apply_group_name
  name              = var.ike_proposal_name
  lifetime__seconds = "1000"
}

// IKE policies
resource "junos-ike_SecurityIkePolicyName" "ike_policy_name" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_policy_name
}

resource "junos-ike_SecurityIkePolicyDescription" "ike_policy_description" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_policy_name
  description   = "This is an IKE policy description"
}

resource "junos-ike_SecurityIkePolicyMode" "ike_policy_mode" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_policy_name
  mode          = "main"
}

resource "junos-ike_SecurityIkePolicyPre__Shared__KeyAscii__Text" "ike_policy_preshared" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_policy_name
  ascii__text   = "juniper123"
  lifecycle {
    ignore_changes = [
      ascii__text,
    ]
  }
}

resource "junos-ike_SecurityIkePolicyProposals" "ike_policy_proposals" {
  resource_name = var.ike_apply_group_name
  name          = var.ike_policy_name
  proposals     = var.ike_proposal_name
}