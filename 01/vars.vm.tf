#Блок образа Nat
variable "vm_web_name_image_public" {
  default     = "nat-instance-ubuntu"
  #description = "VPC network NAT subnet name"
}

#Блок образа 
variable "vm_web_name_image_private" {
  default     = "ubuntu-2004-lts"
  #description = "VPC network private subnet name"
}


#Блок для ввода итератора count_public
variable "count_iterrator_public"{ 
  default = 1
  description = "count_iterrator_public"
}
#Блок для ввода итератора count_private
variable "count_iterrator_private"{ 
  default = 1
  description = "count_iterrator_private"
}



#Переменная для создания ВМ 
variable "vm_resource" {
  type = map(object({  
    vm_name=string, 
    platform = string,
    cpu=number, 
    ram=number, 
    core_fraction = number,
    nat = bool,
    disk_type = string,
    disk_size = number
    }))
  default = { 
    "public" = {
      vm_name="nat", 
      platform = "standard-v1"
      cpu=2, 
      ram=4, 
      core_fraction = 20, 
      nat = true,
      disk_type = "network-hdd" ,
      disk_size = 30
    } ,

    "private"= {
      vm_name="nodes", 
      platform = "standard-v1"
      cpu=2, 
      ram=4, 
      core_fraction = 20, 
      nat = false,
      disk_type = "network-hdd" ,
      disk_size = 30
    } ,
  }
}