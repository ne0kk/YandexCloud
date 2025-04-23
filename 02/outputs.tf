
output "public" {
  value = tomap({
    for inst in yandex_compute_instance.public : inst.name => {
      name                = inst.name
      id                  = inst.id
      fqdn                = inst.fqdn
      ipexternal          = inst.network_interface[0].nat_ip_address
      iplocal             = inst.network_interface[0].ip_address
    }
  })
}

output "private" {
  value = tomap({
    for inst in yandex_compute_instance.private : inst.name => {
      name                = inst.name
      id                  = inst.id
      fqdn                = inst.fqdn
      ipexternal          = inst.network_interface[0].nat_ip_address
      iplocal             = inst.network_interface[0].ip_address
    }
  })
}
