locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys = file("~/.ssh/id_ed25519")
}

variable "yandex_token" {
  type        = string
  default     = "y0_AgAAAAAfi-HGAATuwQAAAAEJYlUlAAA2pEqbHMJN4qZ4MZkuh0xI7QlLHA"
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