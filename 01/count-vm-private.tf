
data "yandex_compute_image" "ubuntu-private" {
  family = var.vm_web_name_image_private
}

resource "yandex_compute_instance" "private" {
  #depends_on = "" #[yandex_compute_instance.bastion]

  count = var.count_iterrator_private

  name        = "${var.vm_resource.private.vm_name}-0${count.index+1}" #Имя ВМ в облачной консоли
  hostname    = "${var.vm_resource.private.vm_name}-0${count.index+1}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.vm_resource.private.platform

  resources {
    cores         = var.vm_resource.private.cpu
    memory        = var.vm_resource.private.ram
    core_fraction = var.vm_resource.private.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-private.image_id
      type     = var.vm_resource.private.disk_type
      size     = var.vm_resource.private.disk_size
    }
  }

  metadata = local.metadata_pub

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = var.vm_resource.private.nat
  }
}