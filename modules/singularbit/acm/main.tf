resource "aws_acm_certificate" "acm_certificate" {

  domain_name               = "${var.subdomain}.${var.domain}"
  subject_alternative_names = ["${var.subdomain}.${var.domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  tags = var.custom_tags
}

# https://stackoverflow.com/questions/57644466/missing-dns-validation-record-when-using-terraform-aws-acm-certificate-validatio
resource "aws_route53_record" "route53_record_validation" {

  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
#  zone_id         = var.route53_zone_id
  zone_id         = data.aws_route53_zone.route53_zone.id

}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {

  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record_validation : record.fqdn]

}
