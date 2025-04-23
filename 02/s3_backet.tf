resource "yandex_iam_service_account" "sa_bucket" {
  folder_id = var.yandex_folder_id
  name      = "sa-bucket"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
  folder_id = var.yandex_folder_id
  role      = var.role_sa
  member    = "serviceAccount:${yandex_iam_service_account.sa_bucket.id}"
  depends_on = [yandex_iam_service_account.sa_bucket]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa_bucket.id
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
  key    = "tree"
  source = var.source_file
  acl = var.acl_bucket_homework_name
  depends_on = [yandex_storage_bucket.s3backet]
}
