resource "aws_lambda_function" "aurora_tag_update" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename         = data.archive_file.lambda.output_path
  function_name    = local.name
  role             = aws_iam_role.aurora_replica_tag_update.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = local.runtime
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_permission" "logging" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aurora_tag_update.function_name
  principal     = "events.amazonaws.com"
  source_arn    = module.eventbridge.eventbridge_rules.aurora_replica_tag_update.arn
}
