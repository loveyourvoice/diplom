# kms провайдер
resource "yandex_kms_symmetric_key" "kms_key_k8s" {
  name = "kms_key_k8s"

  description = "KMS key Kubernetes cluster"
  rotation_period = "3620h"

  deletion_protection = false
}

# кластер
resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name        = "k8s-cluster"
  network_id  = yandex_vpc_network.project_network.id

  master {
    version = "1.27"

    regional {
    region = "ru-central1"
    location {
          subnet_id = yandex_vpc_subnet.project_subnet1.id
          zone      = yandex_vpc_subnet.project_subnet1.zone
        }
    location {
          subnet_id = yandex_vpc_subnet.project_subnet2.id
          zone      = yandex_vpc_subnet.project_subnet2.zone
        }
    location {
          subnet_id = yandex_vpc_subnet.project_subnet3.id
          zone      = yandex_vpc_subnet.project_subnet3.zone
        }
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }

    master_logging {
      enabled = true
      folder_id = var.folder_id
      kube_apiserver_enabled = true
      cluster_autoscaler_enabled = true
      events_enabled = true
      audit_enabled = true
    }
  }

  service_account_id      = yandex_iam_service_account.k8s-sa.id
  node_service_account_id = yandex_iam_service_account.k8s-sa.id

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms_key_k8s.id
  }
}
