provider "google" {
  credentials = "${file("gcp_crd.json")}"
  project = "${var.project}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

variable "project" {
  default       = "echo-final-project"
}
//resource "google_project" "my_project" {
//  name       = "${var.project}"
//  project_id = "${var.project}"
//  org_id     = "1234"
//}
