resource "aws_route53_zone" "norfolkgaming" {
  name = "norfolkgaming.com"
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.norfolkgaming.zone_id
  name    = "norfolkgaming.com"
  type    = "NS"
  ttl     = "172800"
  allow_overwrite = true
  records = [
    "ns-493.awsdns-61.com.",
    "ns-1964.awsdns-53.co.uk.",
    "ns-1070.awsdns-05.org.",
    "ns-954.awsdns-55.net."
  ]
}

resource "aws_route53_record" "soa" {
  zone_id = aws_route53_zone.norfolkgaming.zone_id
  name    = "norfolkgaming.com"
  type    = "SOA"
  ttl     = "900"
  allow_overwrite = true
  records = [
    "ns-493.awsdns-61.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
}
