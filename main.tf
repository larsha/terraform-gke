data "google_container_engine_versions" "versions" {
  zone = "${var.zone}"
}

resource "google_container_cluster" "cluster" {
  name                      = "${var.cluster_name}"
  project                   = "${var.project}"
  zone                      = "${var.zone}"
  min_master_version        = "${data.google_container_engine_versions.versions.latest_master_version}"
  node_version              = "${data.google_container_engine_versions.versions.latest_node_version}"
  remove_default_node_pool  = true

  lifecycle {
    ignore_changes = [
      "network",
      "node_pool"
    ]
  }

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "node_pool" {
  name        = "primary-pool"
  project     = "${var.project}"
  cluster     = "${google_container_cluster.cluster.name}"
  zone        = "${var.zone}"
  node_count  = "${var.node_count}"

  node_config {
    machine_type  = "${var.machine_type}"
    disk_size_gb  = "${var.disk_size_gb}"

    # https://developers.google.com/identity/protocols/googlescopes
    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/sqlservice.admin"
    ]
  }

  management {
    auto_repair   = true
    auto_upgrade  = false
  }

  autoscaling {
    min_node_count  = "${var.node_count}"
    max_node_count  = "${var.node_count + var.node_count}"
  }

  provisioner "local-exec" {
    command = "./local-exec/setup.sh ${google_container_cluster.cluster.name} ${var.zone} ${var.project}"
  }
}
