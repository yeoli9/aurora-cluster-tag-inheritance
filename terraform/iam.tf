data "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role" "aurora_replica_tag_update" {
  name               = local.name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
  managed_policy_arns = [
    data.aws_iam_policy.lambda_execution.arn,
    aws_iam_policy.aurora_replica_tag_update.arn
  ]
}

data "aws_iam_policy_document" "lambda_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "aurora_replica_tag_update" {
  statement {
    actions = [
      "rds:AddTagsToResource",
      "rds:RemoveTagsFromResource",
      "rds:DescribeDBClusters"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "aurora_replica_tag_update" {
  name   = local.name
  policy = data.aws_iam_policy_document.aurora_replica_tag_update.json
}
