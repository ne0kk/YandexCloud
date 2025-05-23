

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = var.sa_id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "s3backet" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket = var.bucket_homework_name
  acl    = var.acl_bucket_homework_name
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "yandex_storage_object" "cat-picture" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket = var.bucket_homework_name
  key    = "images.jpg"
  source = var.source_file
  acl = var.acl_bucket_homework_name
  depends_on = [yandex_storage_bucket.s3backet]
}
