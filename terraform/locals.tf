locals {

  custom_tags = data.aws_default_tags.default.tags

  static_website_pipeline_codestar_connection_name = "${var.project_name}-substr(${var.aws_account_id}, -4, 4)"

}
