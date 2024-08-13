# Создаем сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "terraform-sa"
}

# Присваиваем роль редактора хранилища сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

#Создаем ключ для шифрования
resource "yandex_kms_symmetric_key" "encryption_key" {
  name              = "myencrypts"
  description       = "Key for bucket encryption"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
#Создаем статический ключ доступа для сервисного аккаунта
resource "yandex_iam_service_account_static_access_key" "tf_service_key_new" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Статический ключ"
}

# Создаем бакет в объектном хранилище для хранения state tf
resource "yandex_storage_bucket" "storage_bucket" {
  access_key = yandex_iam_service_account_static_access_key.tf_service_key_new.access_key
  secret_key = yandex_iam_service_account_static_access_key.tf_service_key_new.secret_key
  bucket     = "loveyourvoice-state-bucket"
}

# Определяем политику IAM для роли редактора хранилища
data "yandex_iam_policy" "storage_editor_policy" {
  binding {
    role = "storage.editor"

    members = [
      "userAccount:${yandex_iam_service_account.sa.id}",
    ]
  }
}

# Применяем политику IAM к сервисному аккаунту
resource "yandex_iam_service_account_iam_policy" "sa_editor_policy" {
  service_account_id = yandex_iam_service_account.sa.id
  policy_data        = data.yandex_iam_policy.storage_editor_policy.policy_data
}

# Настраиваем провайдера через template
resource "local_file" "providers" { 
  content = templatefile("./template/providers.tftpl", {
    bucket_name = "loveyourvoice-state-bucket"
    cloud_id    = var.cloud_id
    folder_id   = var.folder_id
  })
  filename = "../providers.tf"
}

# Кладем секрет и ключ в ~/.aws/credentials
resource "local_file" "aws_credentials" {
  content = <<EOT
[default]
aws_access_key_id = ${yandex_iam_service_account_static_access_key.tf_service_key_new.access_key}
aws_secret_access_key = ${yandex_iam_service_account_static_access_key.tf_service_key_new.secret_key}
EOT

  filename = "${pathexpand("~/.aws/credentials")}"
}
