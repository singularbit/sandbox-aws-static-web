########################################################################################
### PART 1: STANDALONE RESOURCES ###
########################################################################################

# ---------------------------------------------------------------------------------------------------------------------
# ACM CERTIFICATE IN US-EAST-1 FOR CDN CLOUDFRONT
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "acm_certificate_4_cdn" {
  for_each = var.static_websites_variables

  source = "../modules/singularbit/acm"

  providers = {
    aws = aws.us
  }

  subdomain = each.value.static_website_subdomain
  #  domain    = data.aws_route53_zone.route53_zone.name
  domain    = each.value.static_website_route53_zone_name

  #  route53_zone_id = data.aws_route53_zone.route53_zone.id

  custom_tags = merge({
    #    "Name" = "${var.project_name}-${each.value.static_website_repository_branch}"
    "Name" = "${var.project_name}-${each.key}"
  }, local.custom_tags)

}


########################################################################################
### PART 2: CDN/DNS, S3 WEBSITE(S)/FAILOVER(S) & DNS LOGS ###
########################################################################################

module "static_website" {
  for_each = var.static_websites_variables

  depends_on = [module.acm_certificate_4_cdn]

  source = "../modules/singularbit/static-website"

  custom_tags        = local.custom_tags
  project_name       = var.project_name
  account_id_4_chars = substr(var.aws_account_id, -4, 4)

  static_website_key                     = each.key
  static_website_subdomain               = each.value.static_website_subdomain
  #  static_website_repository_branch       = each.value.static_website_repository_branch
  static_website_index_document          = each.value.static_website_index_document
  static_website_error_document          = each.value.static_website_error_document
  static_website_cdn_default_root_object = each.value.static_website_cdn_default_root_object

  #  hosted_zone_name = data.aws_route53_zone.route53_zone.name
  hosted_zone_name = each.value.static_website_route53_zone_name
  #  hosted_zone_id   = data.aws_route53_zone.route53_zone.id

  acm_certificate_arn = module.acm_certificate_4_cdn[each.key].acm_certificate_arn[0]

}

#########################################################################################
#### PART 3: CICD PIPELINE(S) ###
#########################################################################################

module "static_website_cicd" {
  for_each = var.static_websites_variables

  depends_on = [module.static_website]

  source = "../modules/singularbit/static-website-cicd"

  custom_tags        = local.custom_tags
  project_name       = var.project_name
  account_id_4_chars = substr(var.aws_account_id, -4, 4)

  static_website_repository_branch = each.value.static_website_repository_branch

  static_website_key             = each.key
  static_website_account_id      = each.value.static_website_account_id
  static_website_region          = each.value.static_website_region
  static_website_repository_name = each.value.static_website_repository_name
  static_website_bucket_name     = module.static_website[each.key].s3_4_static_website[0]

  static_website_cdn_id = module.static_website[each.key].cdn_4_static_website_id[0]

  static_website_pipeline_codestar_connection_name     = each.value.static_website_pipeline_codestar_connection_name
  static_website_pipeline_codestar_connection_provider = each.value.static_website_pipeline_codestar_connection_provider

  static_website_pipeline_build_stages = each.value.static_website_pipeline_build_stages

}
