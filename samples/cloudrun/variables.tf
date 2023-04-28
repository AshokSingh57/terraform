variable "credentials_file" {
  description = "GCP credentials file fully qualified path"
  type        = string
  default     = ""
}

variable "gcp_project_name" {
  description = "GCP project name"
  type        = string
  default     = ""
}

variable "gcp_region" {
  description = "GCP region name"
  type        = string
  default     = ""
}

variable "gcp_zone" {
  description = "GCP zone"
  type        = string
  default     = ""
}

variable "gcp_pubsub_topic_1" {
  description = "pubsub topic 1"
  type        = string
  default     = ""
}

variable "gcp_containerimage" {
  description = "pubsub container image"
  type        = string
  default     = ""
}
