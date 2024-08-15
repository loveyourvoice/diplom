terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "loveyourvoice-state-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true 
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  access_key = var.access_key
  secret_key = var.secret_key
}