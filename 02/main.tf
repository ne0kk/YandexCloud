resource "yandex_vpc_network" "yc_net_home" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.yc_net_home.id
  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = var.private_cidr
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.yc_net_home.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_route_table" "nat-route-table" {
  network_id            = yandex_vpc_network.yc_net_home.id

  static_route {
    destination_prefix  = "0.0.0.0/0"
    next_hop_address    = var.nat-instance-ip
  }
}