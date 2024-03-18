# ---------------------------------------------------------------------------------------------------------------------
# S3 FOR CLOUDFRONT LOGS
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_cdn_logs" {
  source = "../s3"

  bucket_name = "${var.project_name}-${var.static_website_key}-cdn-logs-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = true

  set_bucket_acl_private         = true
  set_bucket_versioning_enabled  = true
  set_bucket_policy_access_block = true

  set_bucket_ownership_controls = true
  object_ownership              = "ObjectWriter" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = false

  set_s3_bucket_policy = false

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}"
  }, var.custom_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 FOR STATIC WEBSITE
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_static_website" {
  source = "../s3"

  bucket_name = "${var.project_name}-${var.static_website_key}-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = false # true
  encryption_algorithm                            = "aws:kms" # AES256, aws:kms, aws:kms:dsse

  set_bucket_acl_private         = false
  set_bucket_versioning_enabled  = false # true
  set_bucket_policy_access_block = false

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = true
  website_index_document              = var.static_website_index_document
  website_error_document              = var.static_website_error_document

  # Define your own policy for the bucket
  set_s3_bucket_policy  = true
  s3_bucket_policy_file = "s3_bucket_policy.json.tpl"
  cdn_oai_iam_arn       = module.cdn_4_static_website.cdn_oai_iam_arn

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}"
  }, var.custom_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 FOR STATIC WEBSITE - FAILOVER
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_static_website_failover" {
  source = "../s3"

  bucket_name = "${var.project_name}-${var.static_website_key}-failover-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = false # true
  encryption_algorithm                            = "aws:kms" # AES256, aws:kms, aws:kms:dsse

  set_bucket_acl_private         = false
  set_bucket_versioning_enabled  = false # true
  set_bucket_policy_access_block = false

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = true
  website_index_document              = var.static_website_index_document
  website_error_document              = var.static_website_error_document

  # Define your own policy for the bucket
  set_s3_bucket_policy  = true
  s3_bucket_policy_file = "s3_bucket_policy.json.tpl"
  cdn_oai_iam_arn       = module.cdn_4_static_website.cdn_oai_iam_arn

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}-failover-${var.account_id_4_chars}"
  }, var.custom_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDFRONT AND ROUTE53 FOR STATIC WEBSITE
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "cdn_4_static_website" {
  source = "./modules/cdn"

  depends_on = [
    module.s3_4_cdn_logs
  ]

  s3_cdn_logs_domain_name = module.s3_4_cdn_logs.s3_domain_name
  s3_cdn_logs_prefix      = "${var.project_name}-${var.static_website_key}-${var.account_id_4_chars}"
  s3_regional_domain_name = module.s3_4_static_website.s3_domain_name
  s3_failover_domain_name = module.s3_4_static_website_failover.s3_domain_name
#  s3_regional_domain_name = module.s3_4_static_website.s3_website_domain
#  s3_failover_domain_name = module.s3_4_static_website_failover.s3_website_domain

  default_root_object = var.static_website_cdn_default_root_object

#  cloudfront_alias = var.static_website_repository_branch
  cloudfront_alias = var.static_website_subdomain
  hosted_zone_name = var.hosted_zone_name
#  hosted_zone_id   = var.hosted_zone_id
  hosted_zone_id   = data.aws_route53_zone.route53_zone.id

  # Created in a previous module
  acm_certificate_arn = var.acm_certificate_arn

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}-${var.account_id_4_chars}"
  }, var.custom_tags)
}