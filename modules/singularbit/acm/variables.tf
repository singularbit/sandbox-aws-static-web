variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - ACM
# ---------------------------------------------------------------------------------------------------------------------
variable "subdomain" {
  description = "Subdomain"
  type = string
  default = ""
}
variable "domain" {
  description = "Domain"
  type = string
  default = ""
}
#variable "route53_zone_id" {
#  description = "Route53 Zone ID"
#  type = string
#  default = ""
#}
