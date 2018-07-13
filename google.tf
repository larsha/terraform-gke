provider "google" {
  version = "~> 1.16"
  project = "${var.project}"
  zone    = "${var.zone}"
}