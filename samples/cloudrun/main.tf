/** Develop the infrastructure for https://cloud.google.com/run/docs/tutorials/pubsub
**/

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.gcp_project_name
  region      = var.gcp_region
  zone        = var.gcp_zone
}

# Project data
data "google_project" "project" {
}

# Enable Cloud Run API
resource "google_project_service" "cloudrun_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}


resource "google_pubsub_topic" "topic-1" {
  name = var.gcp_pubsub_topic_1
}

resource "google_pubsub_topic" "topic-2" {
  name = var.gcp_pubsub_topic_2
}

resource "google_cloud_run_service" "default" {

  name     = var.gcp_run_pubsub
  location = var.gcp_region
  metadata {
		  annotations = {
			  "run.googleapis.com/launch-stage"  = "BETA"
		  }
	  }
  template {
    spec {
      containers {
        image = var.gcp_containerimage
      }
    }
    metadata {
     annotations = {
     "run.googleapis.com/launch-stage"  = "BETA" 
 #    "autoscaling.knative.dev/minScale" = "5"
 #   "autoscaling.knative.dev/maxScale" = "1000"
        }
      }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
   
  depends_on = [google_project_service.cloudrun_api]
}

resource "google_service_account" "sa" {
  account_id   = "cloud-run-pubsub-invoker"
  display_name = "Cloud Run Pub/Sub Invoker"
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  members  = ["serviceAccount:${google_service_account.sa.email}"]
}

resource "google_project_service_identity" "pubsub_agent" {
  provider = google-beta
  project  = data.google_project.project.project_id
  service  = "pubsub.googleapis.com"
}

resource "google_project_iam_binding" "project_token_creator" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_project_service_identity.pubsub_agent.email}"]
}

resource "google_pubsub_subscription" "subscription-1" {
  name  = var.gcp_pubsub_subscription_1
  topic = var.gcp_pubsub_topic_1
  push_config {
    push_endpoint = google_cloud_run_service.default.status[0].url
    oidc_token {
      service_account_email = google_service_account.sa.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
  depends_on = [google_cloud_run_service.default]
}

resource "google_pubsub_subscription" "subscription-2" {
  name  = var.gcp_pubsub_subscription_2
  topic = var.gcp_pubsub_topic_2
  push_config {
    push_endpoint = google_cloud_run_service.default.status[0].url
    oidc_token {
      service_account_email = google_service_account.sa.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
  depends_on = [google_cloud_run_service.default]
}

