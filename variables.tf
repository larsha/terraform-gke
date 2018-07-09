variable "project" {
  description = "Project ID on Google Cloud"
}

variable "cluster_name" {
  default = "bumblebee"
}

variable "zone" {
  default = "europe-north1-a"
}

variable "node_count" {
  default = "3"
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "disk_size_gb" {
  default = "50"
}