packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

variable "project_id" {
  type    = string
  default = "sales-209522"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "image_name" {
  type        = string
  description = "Name for the output GCE image"
}

variable "source_image_family" {
  type    = string
  default = "debian-12"
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

source "googlecompute" "mig-app" {
  project_id          = var.project_id
  zone                = var.zone
  source_image_family = var.source_image_family
  image_name          = var.image_name
  image_description   = "MIG demo application image built by Packer"
  image_labels = {
    managed-by  = "packer"
    environment = "demo"
  }
  machine_type = var.machine_type
  disk_size    = var.disk_size
  ssh_username = "packer"
  tags         = ["http-server"]
}

build {
  sources = ["sources.googlecompute.mig-app"]

  provisioner "shell" {
    scripts = [
      "packer/scripts/setup.sh",
      "packer/scripts/install-app.sh",
      "packer/scripts/cleanup.sh"
    ]
  }
}
