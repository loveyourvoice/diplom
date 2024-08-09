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
    access_key = "YCAJE_2hzxp-HgB1DhSRChowH"
    secret_key = "YCNkBlDs8rG8-rpQtj2KIfzcCBMyLnLez_QsY7jj"
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
}