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
variable "static_website_repository_branch" {
  description = "The branch of the static website repository to use"
  type        = string
  default     = "main"
}

variable "static_website_account_id" {
  description = "Account ID"
  type        = string
  default     = ""
}
variable "static_website_region" {
  description = "Region"
  type        = string
  default     = ""
}
variable "static_website_repository_name" {
  description = "Repository Name"
  type        = string
  default     = ""
}
#variable "static_website_repository_branch" {
#  description = "Repository Branch"
#  type        = string
#  default     = ""
#}
variable "static_website_bucket_name" {
  description = "Bucket Name"
  type        = string
  default     = ""
}

variable "static_website_pipeline_codestar_connection_name" {
  description = "CodeStar Connection Name"
  type        = string
  default     = ""
}
variable "static_website_pipeline_codestar_connection_provider" {
  description = "CodeStar Connection Provider"
  type        = string
  default     = ""
}

#variable "static_website_index_document" {
#  description = "Document Index"
#  type        = string
#  default     = ""
#}
#variable "static_website_error_document" {
#  description = "Document error"
#  type        = string
#  default     = ""
#}
#variable "static_website_cdn_default_root_object" {
#  description = "Default Root Object"
#  type        = string
#  default     = ""
#}

variable "static_website_pipeline_build_stages" {
  description = "Build Stages Map for CodePipeline"
  type        = map(any)
  default     = {}
}
variable "static_website_cdn_id" {
  description = "CDN ID"
  type        = string
  default     = ""
}