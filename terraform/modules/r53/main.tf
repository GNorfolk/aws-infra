resource "aws_route53_zone" "norfolkgaming" {
  name = "norfolkgaming.com"
}

# resource "aws_route53_record" "ns" {
#   zone_id = aws_route53_zone.norfolkgaming.zone_id
#   name    = "norfolkgaming.com"
#   type    = "NS"
#   ttl     = "172800"
#   allow_overwrite = true
#   records = [
#     "ns-332.awsdns-41.com.",
#     "ns-893.awsdns-47.net.",
#     "ns-1889.awsdns-44.co.uk.",
#     "ns-1217.awsdns-24.org."
#   ]
# }
#
# resource "aws_route53_record" "soa" {
#   zone_id = aws_route53_zone.norfolkgaming.zone_id
#   name    = "norfolkgaming.com"
#   type    = "SOA"
#   ttl     = "900"
#   allow_overwrite = true
#   records = [
#     "ns-332.awsdns-41.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
#   ]
# }
