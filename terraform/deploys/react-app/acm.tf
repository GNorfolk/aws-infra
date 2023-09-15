resource "aws_acm_certificate" "this" {
    domain_name = "klofron.uk"
    subject_alternative_names = ["*.klofron.uk"]
    validation_method = "DNS"
}

resource "aws_route53_record" "validation" {
    zone_id = aws_route53_zone.main.zone_id
    name = "_cb38710c3d02f35dfc40cf526eb9f7f9"
    type = "CNAME"
    records = ["_6d264440e383229843f89ea01f1ac7c0.yghrkwvzvz.acm-validations.aws."]
    ttl = 60
}

resource "aws_acm_certificate" "us-east-1" {
    provider = aws.us-east-1
    domain_name = "klofron.uk"
    subject_alternative_names = ["*.klofron.uk"]
    validation_method = "DNS"
}
