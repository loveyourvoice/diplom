resource "null_resource" "get_kubeconfig" {
  provisioner "local-exec" {
    command = "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s-cluster.id} --external --force > ~/.kube/config"
  }
}