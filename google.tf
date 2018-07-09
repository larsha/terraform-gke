provider "google" {
  version = "~> 1.15"
  project = "${var.project}"
  zone    = "${var.zone}"
}