
data "yandex_compute_image" "ubuntu-public" {
  family = var.vm_web_name_image_public
}

resource "yandex_compute_instance_group" "public" {
  #depends_on = "" #[yandex_compute_instance.bastion]

  count = var.count_iterrator_public

  name        = "${var.vm_resource.public.vm_name}-0${count.index+1}" #Имя ВМ в облачной консоли
  hostname    = "${var.vm_resource.public.vm_name}-0${count.index+1}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.vm_resource.public.platform

  resources {
    cores         = var.vm_resource.public.cpu
    memory        = var.vm_resource.public.ram
    core_fraction = var.vm_resource.public.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-public.image_id
      type     = var.vm_resource.public.disk_type
      size     = var.vm_resource.public.disk_size
    }
  }

  metadata = local.metadata_pub


  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = var.vm_resource.public.nat
    ip_address = var.nat-instance-ip
  }

  load_balancer {
    target_group_name        = "target-group-lamp"
    target_group_description = "load balancer target group lamp"
  }
}
