resource "yandex_iam_service_account" "k8s-sa" {
  folder_id = var.folder_id
  name      = "terraform-service-account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-editor" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
  ]
  depends_on = [
    yandex_iam_service_account.k8s-sa
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-images-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
  ]
  depends_on = [
    yandex_iam_service_account.k8s-sa
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "subnet_user_role" {
  folder_id = var.folder_id
  role      = "vpc.user"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
  ]
  depends_on = [
    yandex_iam_service_account.k8s-sa,
    yandex_vpc_subnet.project_subnet1,
    yandex_vpc_subnet.project_subnet2
  ]
}