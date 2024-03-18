locals {
  environment_variables = jsonencode([
    {
      name  = "AWS_ACCOUNT"
      value = var.static_website_account_id
    },
    {
      name  = "AWS_REGION"
      value = var.static_website_region
    },
    {
      name  = "BRANCH"
      value = var.static_website_repository_branch
    },
    {
      name  = "PROJECT"
      value = var.project_name
    },
    {
      name  = "AWS_S3_BUCKET"
      value = var.static_website_bucket_name
    },
    {
      name  = "CDN_ID"
      value = var.static_website_cdn_id
    }
  ])
}

resource "aws_codestarconnections_connection" "codestarconnections_connection" {
  name          = var.static_website_pipeline_codestar_connection_name
  provider_type = var.static_website_pipeline_codestar_connection_provider
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_name}-${var.static_website_key}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket_codepipeline_artifacts
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source-${var.project_name}-${var.static_website_key}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.codestarconnections_connection.arn
        FullRepositoryId     = var.static_website_repository_name
        BranchName           = var.static_website_repository_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build_REACT"

    action {
      name             = aws_codebuild_project.codebuild_deployment["build"].name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName          = aws_codebuild_project.codebuild_deployment["build"].name
        EnvironmentVariables = local.environment_variables
      }
    }
  }

  stage {
    name = "Wait_For_Approval"

    action {
      name      = "ApprovalAction"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 2
    }
  }

  stage {
    name = "Deploy_To_S3"

    action {
      name            = aws_codebuild_project.codebuild_deployment["deploy"].name
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["build_output"]

      configuration = {
        ProjectName          = aws_codebuild_project.codebuild_deployment["deploy"].name
        EnvironmentVariables = local.environment_variables
      }
    }
  }

  stage {
    name = "Invalidate_CDN"

    action {
      name            = aws_codebuild_project.codebuild_deployment["cdn"].name
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 4
      input_artifacts = ["source_output"]

      configuration = {
        ProjectName          = aws_codebuild_project.codebuild_deployment["cdn"].name
        EnvironmentVariables = local.environment_variables
      }
    }
  }

}