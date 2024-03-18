## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
## GLOBAL VARIABLES
## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = ""
}
variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = ""
}


## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
## CLOUDFORMATION IMPORTS
## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
variable "cloudformation_stack_name" {
  description = "The name of the CloudFormation stack"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - WEB ACL
# ---------------------------------------------------------------------------------------------------------------------
## Route53
#variable "route53_zone_name" {
#  description = "The name of the Route53 zone"
#  type        = string
#  default     = ""
#}

# IP SET
variable "static_website_ip_set_name" {
  description = "IP Set Name"
  type        = string
  default     = ""
}
variable "static_website_ip_set_description" {
  description = "IP Set Description"
  type        = string
  default     = ""
}
variable "static_website_ip_set_scope" {
  description = "IP Set Scope"
  type        = string
  default     = ""
}
variable "static_website_ip_set_addresses" {
  description = "IP Set Addresses"
  type        = list(string)
  default     = []
}

# WEB ACL
variable "static_website_web_acl_name" {
  description = "Web ACL Name"
  type        = string
  default     = ""
}
variable "static_website_web_acl_description" {
  description = "Web ACL Description"
  type        = string
  default     = ""
}
variable "static_website_web_acl_scope" {
  description = "Web ACL Scope"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - STATIC WEBSITE(S)
# ---------------------------------------------------------------------------------------------------------------------
variable "static_websites_variables" {
  description = "Static Website Variables"
  type        = map(object({
    static_website_route53_zone_name       = string
    static_website_subdomain               = string
    static_website_repository_branch       = string
    static_website_index_document          = string
    static_website_error_document          = string
    static_website_cdn_default_root_object = string

    static_website_account_id                            = string
    static_website_region                                = string
    static_website_repository_name                       = string
    static_website_pipeline_codestar_connection_name     = string
    static_website_pipeline_codestar_connection_provider = string
    static_website_pipeline_build_stages                 = map(any)
  }))
  default = {}
}
