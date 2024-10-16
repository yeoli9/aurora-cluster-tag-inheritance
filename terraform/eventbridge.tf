module "eventbridge" {
  source     = "terraform-aws-modules/eventbridge/aws"
  create_bus = false
  rules = {
    aurora_replica_tag_update = {
      description = "Capture CreateDBInstance APIs"
      event_pattern = jsonencode(
        {
          "source" : ["aws.rds"],
          "detail-type" : ["AWS API Call via CloudTrail"],
          "detail" : {
            "eventSource" : ["rds.amazonaws.com"],
            "eventName" : ["CreateDBInstance"]
          }
        }
      )
      enabled = true
    }
  }

  targets = {
    aurora_replica_tag_update = [
      {
        name = local.name
        arn  = aws_lambda_function.aurora_tag_update.arn
      }
    ]
  }
}
