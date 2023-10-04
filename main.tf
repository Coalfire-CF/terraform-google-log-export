locals {
  is_project_level = var.parent_resource_type == "project"
  is_folder_level  = var.parent_resource_type == "folder"
  is_org_level     = var.parent_resource_type == "organization"
  is_billing_level = var.parent_resource_type == "billing_account"

  # Locals for outputs to ensure the value is available after the resource is created
  log_sink_writer_identity = local.is_project_level ? element(concat(google_logging_project_sink.sink.*.writer_identity, [""]), 0) : local.is_folder_level ? element(concat(google_logging_folder_sink.sink.*.writer_identity, [""]), 0) : local.is_org_level ? element(concat(google_logging_organization_sink.sink.*.writer_identity, [""]), 0) : local.is_billing_level ? element(concat(google_logging_billing_account_sink.sink.*.writer_identity, [""]), 0) : ""
  log_sink_resource_id     = local.is_project_level ? element(concat(google_logging_project_sink.sink.*.id, [""]), 0) : local.is_folder_level ? element(concat(google_logging_folder_sink.sink.*.id, [""]), 0) : local.is_org_level ? element(concat(google_logging_organization_sink.sink.*.id, [""]), 0) : local.is_billing_level ? element(concat(google_logging_billing_account_sink.sink.*.id, [""]), 0) : ""
  log_sink_resource_name   = local.is_project_level ? element(concat(google_logging_project_sink.sink.*.name, [""]), 0) : local.is_folder_level ? element(concat(google_logging_folder_sink.sink.*.name, [""]), 0) : local.is_org_level ? element(concat(google_logging_organization_sink.sink.*.name, [""]), 0) : local.is_billing_level ? element(concat(google_logging_billing_account_sink.sink.*.name, [""]), 0) : ""
  log_sink_parent_id       = local.is_project_level ? element(concat(google_logging_project_sink.sink.*.project, [""]), 0) : local.is_folder_level ? element(concat(google_logging_folder_sink.sink.*.folder, [""]), 0) : local.is_org_level ? element(concat(google_logging_organization_sink.sink.*.org_id, [""]), 0) : local.is_billing_level ? element(concat(google_logging_billing_account_sink.sink.*.billing_account, [""]), 0) : ""
}

# Org-level
resource "google_logging_organization_sink" "sink" {
  count  = local.is_org_level ? 1 : 0
  org_id = var.parent_resource_id

  name             = var.log_sink_name
  filter           = var.filter
  include_children = var.include_children
  destination      = var.destination_uri

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = exclusions.value.disabled
    }
  }
}

# Folder-level
resource "google_logging_folder_sink" "sink" {
  count  = local.is_folder_level ? 1 : 0
  folder = var.parent_resource_id

  name             = var.log_sink_name
  filter           = var.filter
  include_children = var.include_children
  destination      = var.destination_uri

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = exclusions.value.disabled
    }
  }
}

# Project-level
resource "google_logging_project_sink" "sink" {
  count   = local.is_project_level ? 1 : 0
  project = var.parent_resource_id

  name                   = var.log_sink_name
  filter                 = var.filter
  destination            = var.destination_uri
  unique_writer_identity = var.unique_writer_identity

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = exclusions.value.disabled
    }
  }
}

# Billing Account-level
resource "google_logging_billing_account_sink" "sink" {
  count           = local.is_billing_level ? 1 : 0
  billing_account = var.parent_resource_id

  name        = var.log_sink_name
  filter      = var.filter
  destination = var.destination_uri

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = exclusions.value.disabled
    }
  }
}
