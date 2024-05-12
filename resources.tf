resource "yandex_compute_disk" "test1" {
  name     = "test1"
  type     = "network-hdd"
  size     = 10
  zone     = "ru-central1-a"
  image_id = "fd88m3uah9t47loeseir"

  labels = {
    environment = "test1"
  }
}

resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}

resource "yandex_vpc_subnet" "lab-subnet-a" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.lab-net.id
}

resource "yandex_vpc_address" "addr" {
  name = "test1"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_compute_instance" "vm-1" {
  name        = "test1"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"


  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    disk_id = yandex_compute_disk.test1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.lab-subnet-a.id
    nat       = true
  }

  metadata = {
    user-data = "${file("cloud-init.yaml")}"
  }
  
  scheduling_policy {
    preemptible = true
  }
}