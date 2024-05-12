terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  cloud_id  = "aje789a9p2bcauis64hl"
  folder_id = "b1g5n8seedm7iub1qbob"
}

provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = "ru-central1-a"
  token     = var.token
}