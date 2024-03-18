# ---------------------------------------------------------------------------------------------------------------------
# REACT DEPLOYMENT PIPELINE
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "static_website_pipeline" {

  source = "./modules/pipeline"

  depends_on = [
    module.s3_4_codepipeline_artifacts,
    module.s3_4_codebuild_logs
  ]

  custom_tags  = var.custom_tags
  project_name = var.project_name

  static_website_key               = var.static_website_key
  static_website_account_id        = var.static_website_account_id
  static_website_region            = var.static_website_region
  static_website_repository_name   = var.static_website_repository_name
  static_website_repository_branch = var.static_website_repository_branch
  static_website_bucket_name       = var.static_website_bucket_name
  static_website_cdn_id            = var.static_website_cdn_id

  # CODESTAR CONNECTION
  static_website_pipeline_codestar_connection_name     = var.static_website_pipeline_codestar_connection_name
  static_website_pipeline_codestar_connection_provider = var.static_website_pipeline_codestar_connection_provider

  static_website_pipeline_build_stages = var.static_website_pipeline_build_stages

  s3_bucket_codepipeline_artifacts = module.s3_4_codepipeline_artifacts.s3_bucket

  codebuild_compute_type    = "BUILD_GENERAL1_SMALL" # "BUILD_GENERAL1_LARGE"
  codebuild_roles           = []
  codebuild_privileged_mode = "true"

  # REVIEW THIS
  s3_id_codebuild_logs          = module.s3_4_codebuild_logs.s3_id
  s3_arn_codepipeline_artifacts = module.s3_4_codepipeline_artifacts.s3_arn
  s3_arn_codebuild_logs         = module.s3_4_codebuild_logs.s3_arn

}

# ---------------------------------------------------------------------------------------------------------------------
# S3 ARTIFACT LOCATION FOR CODEPIPELINE AND CODEBUILD
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_codepipeline_artifacts" {
  source = "../s3"

  bucket_name = "${var.project_name}-${var.static_website_key}-codepipeline-artifacts-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = true

  set_bucket_acl_private         = true
  set_bucket_versioning_enabled  = true
  set_bucket_policy_access_block = true

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = false

  set_s3_bucket_policy = false

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}-failover-${var.account_id_4_chars}"
  }, var.custom_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 LOGS LOCATION FOR CODEBUILD
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_codebuild_logs" {
  source = "../s3"

  bucket_name = "${var.project_name}-${var.static_website_key}-codebuild-logs-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = true

  set_bucket_acl_private         = true
  set_bucket_versioning_enabled  = false
  set_bucket_policy_access_block = true

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = false

  set_s3_bucket_policy = false

  custom_tags = merge({
    "Name" = "${var.project_name}-${var.static_website_key}-failover-${var.account_id_4_chars}"
  }, var.custom_tags)
}
