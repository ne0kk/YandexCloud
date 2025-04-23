variable "bucket_homework_name" {
  type        = string
  default = "homework-s3"
  description = "Имя бакета s3"
}

variable "acl_bucket_homework_name" {
  type        = string
  default = "public-read"
  description = "ACL "
}

variable "source_file" {
  type        = string
  default = "./images.jpg"
  description = "image"
}

variable "role_sa" {
  type        = string
  default = "editor"
  description = "image"
}

