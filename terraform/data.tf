# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# AWS Basic
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
data "aws_default_tags" "default" {}
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# CloudFormation Outputs - Terraform Pipeline & Prerequisites
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
data "aws_cloudformation_export" "codepipeline_role_arn" {
  name = "${var.cloudformation_stack_name}-CodePipelineRole"
}
data "aws_cloudformation_export" "codebuild_role_arn" {
  name = "${var.cloudformation_stack_name}-CodeBuildRole"
}
