output "ip" {
  value = data.http.get_public_ip.body
}