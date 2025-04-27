
# Create SA
resource "yandex_iam_service_account" "sa-bucket" {
  name = var.sa_name
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-editor" {
  cloud_id   = var.cloud_id
  role       = var.role_sa
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-encrypter" {
  cloud_id   = var.cloud_id
  role       = "kms.keys.encrypter"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-decrypter" {
  cloud_id   = var.cloud_id
  role       = "kms.keys.decrypter"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}



// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description        = "static access key for bucket"
}


resource "yandex_kms_symmetric_key" "secret-key" {
  name              = "my-entcryption-key"
  description       = "Key for encrypting bucket objects"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}


// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "s3backet" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket = var.bucket_homework_name
  acl    = var.acl_bucket_homework_name
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.secret-key.id
        sse_algorithm     = "aws:kms"
      }
    }
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
