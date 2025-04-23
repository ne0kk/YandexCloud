
data "yandex_compute_image" "ubuntu-public" {
  family = var.vm_web_name_image_public
}

resource "yandex_compute_instance_group" "public" {
  #depends_on = "" #[yandex_compute_instance.bastion]
  service_account_id  = var.sa_id


  
  instance_template {
    platform_id = var.vm_resource.public.platform
    resources {
    cores         = var.vm_resource.public.cpu
    memory        = var.vm_resource.public.ram
    core_fraction = var.vm_resource.public.core_fraction
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-public.image_id
      type     = var.vm_resource.public.disk_type
      size     = var.vm_resource.public.disk_size
    }
  }

  metadata = local.metadata_user_data


  scheduling_policy { preemptible = true }

  network_interface {
    subnet_ids = yandex_vpc_subnet.public.id
    nat       = var.vm_resource.public.nat
    ip_address = var.nat-instance-ip
  }
}
 
  scale_policy {
    fixed_scale {
      size = 3
    }
  }

   allocation_policy {
     zones = ["ru-central1-a"]
   }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  health_check {
    interval = 30
    timeout  = 10
    tcp_options {
      port = 80
    }
  }

  load_balancer {
    target_group_name        = "target-group-lamp"
    target_group_description = "load balancer target group lamp"
  }
}
