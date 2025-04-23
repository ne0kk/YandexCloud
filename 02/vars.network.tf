
variable "vpc_name" {
  type        = string
  default     = "yc_home"
  description = "VPC networ name new"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_subnet_name" {
  type        = string
  default     = "public"
 description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_subnet_name" {
  type        = string
  default     = "private"
 description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "nat-instance-ip" {
  type        = string
  default     = "192.168.10.254"
}