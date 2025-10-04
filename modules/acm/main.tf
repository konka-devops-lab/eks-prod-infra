# locals {
#   name = "${var.environment}-${var.project_name}"
# }
# resource "aws_acm_certificate" "example" {
#   for_each = toset(var.domain_names)
#   domain_name       = each.value
#   validation_method = var.validation_method

#   tags = merge(
#     {
#       Name = local.name
#     },
#     var.common_tags
#   )

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_route53_record" "example" {
#   for_each = {
#     for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = var.zone_id
# }

# resource "aws_acm_certificate_validation" "example" {
#   certificate_arn         = aws_acm_certificate.example.arn
#   validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
# }

locals {
  name = "${var.environment}-${var.project_name}"
}

# Create one ACM certificate per domain
resource "aws_acm_certificate" "this" {
  for_each = toset(var.domain_names)

  domain_name       = each.value
  validation_method = var.validation_method

  tags = merge(
    {
      Name = "${local.name}-${each.value}"
    },
    var.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Create Route53 validation records for each certificate
resource "aws_route53_record" "this" {
  for_each = {
    for cert in aws_acm_certificate.this :
    cert.domain_name => tolist(cert.domain_validation_options)[0]
  }

  zone_id = var.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
  lifecycle {
    create_before_destroy = true
  }
}


# # Validate ACM certificates
# resource "aws_acm_certificate_validation" "this" {
#   for_each = aws_acm_certificate.this

#   certificate_arn = each.value.arn
#   validation_record_fqdns = [
#     aws_route53_record.this[each.key].fqdn
#   ]
# }
