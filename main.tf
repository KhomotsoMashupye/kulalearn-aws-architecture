
provider "aws" {
  region = "us-east-1"
}


resource "aws_iam_role" "lambda_exec_role" {
  name = "kulalearn-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "main_lambda" {
  function_name = "kulalearn-main-lambda"
  runtime       = "nodejs18.x"
  handler       = "lambda_function.handler"
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")
}


resource "aws_s3_bucket" "static_site" {
  bucket = "kulalearn-static-site-${random_id.bucket_id.hex}"

 website {
    index_document = "index.html"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}


resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id   = "kulalearnS3Origin"
  }

  default_cache_behavior {
    target_origin_id       = "kulalearnS3Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_apigatewayv2_api" "http_api" {
  name          = "kulalearn-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.main_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}


resource "aws_sns_topic" "notifications" {
  name = "kulalearn-notifications"
}


resource "aws_sqs_queue" "task_queue" {
  name = "kulalearn-task-queue"
}


resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.main_lambda.function_name}"
  retention_in_days = 7
}


resource "aws_db_instance" "kulalearn_rds" {
  identifier              = "kulalearn-db"
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  engine_version          = "8.0"
  allocated_storage       = 20
  username                = "admin"
  password                = "KulaLearnDB123"
  publicly_accessible     = true
  skip_final_snapshot     = true
}
