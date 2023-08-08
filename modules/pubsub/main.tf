locals {
  destination_uri = "pubsub.googleapis.com/projects/${var.project_id}/topics/${local.topic_name}"
  topic_name      = element(concat(google_pubsub_topic.topic.*.name, [""]), 0)
  pubsub_subscriber = element(
    concat(google_service_account.pubsub_subscriber.*.email, [""]),
    0,
  )
  pubsub_subscription = element(
    concat(google_pubsub_subscription.pubsub_subscription.*.id, [""]),
    0,
  )
  pubsub_push_subscription = element(
    concat(google_pubsub_subscription.pubsub_push_subscription.*.id, [""]),
    0,
  )
  subscriber_id = var.subscriber_id == "" ? "${local.topic_name}-subscriber" : var.subscriber_id
}

resource "google_pubsub_topic" "topic" {
  project = var.project_id

  name         = var.topic_name
  labels       = var.topic_labels
  kms_key_name = var.kms_key_name
}

resource "google_pubsub_topic_iam_member" "pubsub_sink_member" {
  project = var.project_id

  topic  = local.topic_name
  role   = "roles/pubsub.publisher"
  member = var.log_sink_writer_identity
}

resource "google_service_account" "pubsub_subscriber" {
  count   = var.create_subscriber ? 1 : 0
  project = var.project_id

  account_id   = local.subscriber_id
  display_name = "${local.topic_name} Topic Subscriber"
}

resource "google_pubsub_subscription_iam_member" "pubsub_subscriber_role" {
  count   = var.create_subscriber ? 1 : 0
  project = var.project_id

  role         = "roles/pubsub.subscriber"
  subscription = local.pubsub_subscription
  member       = "serviceAccount:${google_service_account.pubsub_subscriber[0].email}"
}

resource "google_pubsub_topic_iam_member" "pubsub_viewer_role" {
  count   = var.create_subscriber ? 1 : 0
  project = var.project_id

  role   = "roles/pubsub.viewer"
  topic  = local.topic_name
  member = "serviceAccount:${google_service_account.pubsub_subscriber[0].email}"
}

resource "google_pubsub_subscription" "pubsub_subscription" {
  count   = var.create_subscriber ? 1 : 0
  project = var.project_id

  name   = "${local.topic_name}-subscription"
  topic  = local.topic_name
  labels = var.subscription_labels
}

resource "google_pubsub_subscription" "pubsub_push_subscription" {
  count   = var.create_push_subscriber ? 1 : 0
  project = var.project_id

  name   = "${local.topic_name}-push-subscription"
  topic  = local.topic_name
  labels = var.subscription_labels

  push_config {
    push_endpoint = var.push_endpoint
  }
}
