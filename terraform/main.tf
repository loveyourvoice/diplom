resource "yandex_vpc_network" "project_network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "project_subnet1" {
  name           = var.subnet_name1
  zone           = var.zone1
  network_id     = yandex_vpc_network.project_network.id
  v4_cidr_blocks = var.cidr1
}

resource "yandex_vpc_subnet" "project_subnet2" {
  name           = var.subnet_name2
  zone           = var.zone2
  network_id     = yandex_vpc_network.project_network.id
  v4_cidr_blocks = var.cidr2
}

resource "yandex_vpc_subnet" "project_subnet3" {
  name           = var.subnet_name3
  zone           = var.zone3
  network_id     = yandex_vpc_network.project_network.id
  v4_cidr_blocks = var.cidr3
}

variable "zone1" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона для первой подсети"
}

variable "zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "Зона для второй подсети"
}

variable "zone3" {
  type        = string
  default     = "ru-central1-d"
  description = "Зона для третьей подсети"
}

variable "cidr1" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "CIDR блоки для первой подсети"
}

variable "cidr2" {
  type        = list(string)
  default     = ["192.168.2.0/24"]
  description = "CIDR блоки для второй подсети"
}

variable "cidr3" {
  type        = list(string)
  default     = ["192.168.3.0/24"]
  description = "CIDR блоки для третьей подсети"
}

variable "network_name" {
  type        = string
  default     = "project-network"
  description = "Имя VPC сети"
}

variable "subnet_name1" {
  type        = string
  default     = "project-subnet1"
  description = "Имя первой подсети"
}

variable "subnet_name2" {
  type        = string
  default     = "project-subnet2"
  description = "Имя второй подсети"
}
variable "subnet_name3" {
  type        = string
  default     = "project-subnet3"
  description = "Имя третьей подсети"
}