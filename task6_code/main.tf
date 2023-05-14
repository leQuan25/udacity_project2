terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  access_key = "ASIA6N7JOYUGLIIIW6SL"
  secret_key = "WzwEkBfSN5QrrXcHDUAzOzJHILmXJ2DzjnI+F0Rh"
  token = "FwoGZXIvYXdzEOH//////////wEaDAl96PNDiSK7DHsVOiLVAYonQZD72w4scjfmOoi6V08435eukOC5RBJQTRgYUKsmeiU6440JREFGjBq0+E9ZYCTh0/vISvNpbNcBTD9ICCoK7f0F1kX5JaMraQL6jPkJOjm9Q05KnAbq909/p0VU+q0nApo6jzTAH2wCfbTn+rrUe4RX1YxTa9B5r4OQBgoUbrVuQJDgGNm9uI/3SkK7mtNjoEOnCWkuHEwyFrL40koRs46uRbIyK+Id/EC2cbn2MEDUsoniSyveyV8BfDAvU9L0OWHQwCce672UBa2FlJIJ+qmiIijJmYKjBjItPdPtevW60DmHdmDUy2ycnpMoar+WvE4FcjlOCrbME/+4oCCyhU58I3WuVJTz"
  region  = "us-west-2"
}

data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = var.lambda_output_path
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logs_policy" {
  name        = "lambda_logs_policy"
  path        = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_logs_policy.arn
}

resource "aws_lambda_function" "geeting_lambda" {
  function_name = var.lambda_name
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.8"
  role = aws_iam_role.lambda_exec_role.arn

  environment{
      variables = {
          greeting = "Greeting!!!"
      }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs_policy, aws_cloudwatch_log_group.lambda_log_group]
}

