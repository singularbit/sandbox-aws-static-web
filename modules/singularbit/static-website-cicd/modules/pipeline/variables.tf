# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - GLOBAL
# ---------------------------------------------------------------------------------------------------------------------
variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = ""
}



variable "cdn_id" {
  description = "CDN Id"
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - STATIC WEBSITE - CODEPIPELINE
# ---------------------------------------------------------------------------------------------------------------------
variable "static_website_key" {
  description = "The key of the static website to use"
  type        = string
  default     = ""
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
variable "static_website_repository_branch" {
  description = "Repository Branch"
  type        = string
  default     = ""
}
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
variable "static_website_cdn_default_root_object" {
  description = "Default Root Object"
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - EXTERNAL RESOURCES
# ---------------------------------------------------------------------------------------------------------------------
variable "s3_bucket_codepipeline_artifacts" {
  description = "S3 Bucket for CodePipeline Artifacts"
  type        = string
  default     = ""
}
variable "s3_arn_codepipeline_artifacts" {
  description = "S3 ARN for CodePipeline Artifacts"
  type        = string
  default     = ""
}
variable "s3_id_codebuild_logs" {
  description = "S3 Bucket for CodeBuild Logs"
  type        = string
  default     = ""
}
variable "s3_arn_codebuild_logs" {
  description = "S3 ARN for CodeBuild Logs"
  type        = string
  default     = ""
}
#variable "codestar_connection_arn" {
#  description = "CodeStar Connection ARN"
#  type        = string
#  default     = ""
#}
#variable "branch_name" {
#  description = "Branch Name"
#  type        = string
#  default     = ""
#}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - GLOBAL - CODEBUILD
# ---------------------------------------------------------------------------------------------------------------------
variable "codebuild_compute_type" {
  description = "The DEFAULT EC2 instance for running CodeBuild"
  type        = string
  default     = ""
}

variable "codebuild_roles" {
  description = "IAM roles to associate to CodeBuild"
  type        = list(any)
  default     = []
}

variable "codebuild_privileged_mode" {
  description = "Enable CodeBuild to use Docker to build images"
  type        = string
  default     = ""
}

variable "codebuild_proxy_config" {
  description = "Proxies used by CodeBuild"
  type =object({
    HTTP_PROXY  = string
    http_proxy  = string
    HTTPS_PROXY = string
    https_proxy = string
    NO_PROXY    = string
    no_proxy    = string
  })
  default = {
    HTTP_PROXY  = ""
    http_proxy  = ""
    HTTPS_PROXY = ""
    https_proxy = ""
    NO_PROXY    = ""
    no_proxy    = ""
  }
}

variable "codebuild_private_vpc_config" {
  description = "Map of values for private VPC, Subnets and Security Groups"
  type = object({
    vpc_id              = string
    subnet_ids          = string
    security_group_ids  = string
  })
  default = {
    vpc_id              = ""
    subnet_ids          = ""
    security_group_ids  = ""
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - MODULE
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "Pipeline Name"
  type        = string
  default     = ""
}

variable "pipeline_repository" {
  description = "Source Repository for CodePipeline"
  type        = string
  default     = ""
}

variable "pipeline_branches" {
  description = "Source Repository Branches for CodePipeline"
  type        = string
  default     = ""
}

variable "build_stages" {
  description = "Build Stages Map for CodePipeline"
  type        = map(any)
  default     = {}
}
