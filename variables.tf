variable "project" {
  description = "Project ID on Google Cloud"
}

variable "cluster_name" {
  description = "Cluster name"
}

variable "zone" {
  description = "Zone on Google Cloud (e.g. europe-north1-a)"
}

variable "node_count" {
  description = "Number of worker nodes"
}

variable "machine_type" {
  description = "Machine type on worker nodes (e.g. n1-standard-2)"
}

variable "disk_size_gb" {
  description = "Disk size in GB for each worker node"
}