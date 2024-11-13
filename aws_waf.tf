resource "aws_wafv2_web_acl" "web_acl" {
  name        = "my-web-acl"
  scope       = "REGIONAL" # Use "CLOUDFRONT" if you're using CloudFront
  description = "Web ACL with AWS Managed Rules excluding CrossSiteScripting_BODY"

  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        # Exclude the CrossSiteScripting_BODY rule
        excluded_rule {
          name = "CrossSiteScripting_BODY"
        }
      }
    }

    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesCommonRuleSet"
    }
  }

  visibility_config {
    sampled_requests_enabled    = true
    cloudwatch_metrics_enabled  = true
    metric_name                 = "myWebACL"
  }
}

# Associate the Web ACL with an API Gateway stage
resource "aws_wafv2_web_acl_association" "api_gateway_assoc" {
  resource_arn = "arn:aws:apigateway:us-east-1::/restapis/<your-api-id>/stages/<your-stage-name>"
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}
