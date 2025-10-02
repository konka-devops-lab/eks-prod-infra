output "certificate_arns" {
  description = "ARNs of all ACM certificates"
  value       = { for domain, cert in aws_acm_certificate.this : domain => cert.arn }
}
