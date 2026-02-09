output "vpc_id" {
  value = aws_vpc.main.id
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
