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
variable "account_id_4_chars" {
  description = "The last 4 characters of account ID"
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - STATIC WEBSITE(S)
# ---------------------------------------------------------------------------------------------------------------------
variable "static_website_key" {
  description = "The key of the static website to use"
  type        = string
  default     = ""
}
#variable "static_website_repository_branch" {
#  description = "The branch of the static website repository to use"
#  type        = string
#  default     = "main"
#}
variable "hosted_zone_name" {
  description = "The name of the hosted zone to use for the static website"
  type        = string
  default     = ""
}
variable "static_website_subdomain" {
  description = "The subdomain to use for the static website"
  type        = string
  default     = ""
}
variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use for the static website"
  type        = string
  default     = ""
}
variable "static_website_index_document" {
  description = "Document Index"
  type        = string
  default     = ""
}
variable "static_website_error_document" {
  description = "Document error"
  type        = string
  default     = ""
}
variable "static_website_cdn_default_root_object" {
  description = "Default Root Object"
  type        = string
  default     = ""
}