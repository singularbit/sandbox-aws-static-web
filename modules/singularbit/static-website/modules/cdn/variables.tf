variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}
variable "s3_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  type        = string
  default     = ""
}
variable "s3_failover_domain_name" {
  description = "The failover domain name of the S3 bucket"
  type        = string
  default     = ""
}

variable "s3_cdn_logs_domain_name" {
  description = "The domain name of the S3 bucket for CDN logs"
  type        = string
  default     = ""
}
variable "s3_cdn_logs_prefix" {
  description = "The prefix for CDN logs"
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "The default root object"
  type        = string
  default     = ""
}
variable "cloudfront_alias" {
  description = "The alias for the CloudFront distribution"
  type        = string
  default     = ""
}

variable "hosted_zone_name" {
  description = "The name of the hosted zone"
  type        = string
  default     = ""
}
variable "hosted_zone_id" {
  description = "The ID of the hosted zone"
  type        = string
  default     = ""
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
  default     = ""
}