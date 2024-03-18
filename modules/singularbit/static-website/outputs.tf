output "s3_4_static_website" {
  value = module.s3_4_static_website.s3_bucket[*]
}
output "cdn_4_static_website_id" {
  value = module.cdn_4_static_website.cdn_id[*]
}