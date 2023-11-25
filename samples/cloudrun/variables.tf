variable "credentials_file" {
  description = "GCP credentials file fully qualified path"
  type        = string
  default     = "<GCP project private key files>.json"
}

variable "gcp_project_name" {
  description = "GCP project name"
  type        = string
  default     = "<GCP Project name>"
}

variable "gcp_project_number" {
  description = "GCP project number"
  type        = string
  default     = "<GCP project number"
}

variable "gcp_region" {
  description = "GCP region name"
  type        = string
  default     = "us-east4"
}

variable "gcp_zone" {
  description = "GCP zone"
  type        = string
  default     = "us-east4-c"
}

variable "gcp_pubsub_topic_1" {
  description = "pubsub topic 1"
  type        = string
  default     = "pubsub-topic-1"
}

variable "gcp_pubsub_topic_2" {
  description = "pubsub topic 2"
  type        = string
  default     = "pubsub-topic-2"
}


variable "gcp_pubsub_subscription_1" {
  description = "pubsub subscription 1"
  type        = string
  default     = "pubsub-subscrription-1"
}

variable "gcp_pubsub_subscription_2" {
  description = "pubsub subscription 2"
  type        = string
  default     = "pubsub-subscrription-2"
}

variable "gcp_run_pubsub" {
  description = "pubsub cloud routine"
  type        = string
  default     = "runpubsub1"
}

variable "gcp_containerimage" {
  description = "pubsub container image"
  type        = string
  default     = "gcr.io/<GCP Project name>/pubsub"
}