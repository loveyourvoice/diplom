locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys = file("~/.ssh/id_ed25519")
}

variable "yandex_token" {
  type = string
}
variable "cloud_id" {
  type = string
}
variable "folder_id" {
  type = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}