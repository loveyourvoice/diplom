terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  token     = var.yandex_token
  cloud_id   = var.cloud_id
  folder_id  = var.folder_id
  zone       = var.default_zone
}
variable "yandex_token" {
  type        = string
}

variable "cloud_id" {
  type        = string
  default     = "b1g8ge6270gbajmfusni"
}

variable "folder_id" {
  type        = string
  default     = "b1gnp65br7d0gc6j0fdn"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}