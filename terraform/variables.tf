locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys = file("~/.ssh/id_ed25519")
}

variable "yandex_token" {}
variable "cloud_id" {}
variable "folder_id" {}
variable "access_key" {}
variable "secret_key" {}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}