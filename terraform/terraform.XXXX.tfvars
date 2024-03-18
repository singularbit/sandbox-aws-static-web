# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# GLOBAL VARIABLES
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
custom_tags    = {}
project_name   = "<project name>"
aws_account_id = "<AWSAccountID>"
aws_region     = "<region>"

# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# VARIABLES - CLOUDFORMATION IMPORTS
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
cloudformation_stack_name = "<the name of the 1st cloudformation stack>" #TODO: (2024-01-12) We need to Import this value!

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - WEB ACL - DEFAULT
# ---------------------------------------------------------------------------------------------------------------------
static_website_ip_set_name        = "default-ip-set"
static_website_ip_set_description = "Whitelist"
static_website_ip_set_scope       = "CLOUDFRONT"
static_website_ip_set_addresses   = []

static_website_web_acl_name        = "default-web-acl"
static_website_web_acl_description = "Default Web ACL"
static_website_web_acl_scope       = "CLOUDFRONT"

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - STATIC WEBSITE(S)
# ---------------------------------------------------------------------------------------------------------------------
# The key values can be anything and must be unique. They are used to name resources.
static_websites_variables = {
  "site1" = {
    static_website_route53_zone_name       = "<the domain.tld you'll be using>"
    static_website_subdomain               = "<subdomain>>" # This is the subdomain for the static website
    static_website_repository_branch       = "<Git Branch>" # This is the branch of the static website repository
    static_website_index_document          = "index.html"
    static_website_error_document          = "error.html"
    static_website_cdn_default_root_object = "index.html"

    static_website_account_id                            = "<AWSAccountID>"
    static_website_region                                = "<Region"
    static_website_repository_name                       = "<Git Repository>"
    static_website_pipeline_codestar_connection_name     = "<Unique Codestar Connection Name>"
    static_website_pipeline_codestar_connection_provider = "GitHub"
    static_website_pipeline_build_stages                 = {
      "build"  = "buildspecs/cicd_pipeline/buildspec_build.yaml"
      "deploy" = "buildspecs/cicd_pipeline/buildspec_deploy.yaml"
      "cdn"    = "buildspecs/cicd_pipeline/buildspec_cdn.yaml"
    }
  },
}