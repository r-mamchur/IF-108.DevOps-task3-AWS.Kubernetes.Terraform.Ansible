output "region" {
  value = var.region
}

output "my_address" {
    value = aws_db_instance.eshool.address
}

output "my_endpoint" {
    value = aws_db_instance.eshool.endpoint
}