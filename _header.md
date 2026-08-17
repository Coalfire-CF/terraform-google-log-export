![Coalfire](coalfire_logo.png)

# Google Cloud Log Export Terraform Module

## Description

This module allows you to create log exports at the project, folder, organization, or billing account level. Coalfire has tested this module with Terraform version 1.5.0 and the Hashicorp Google provider versions 4.70 - 5.0.

FedRAMP Compliance: High

### Usage

```
module "log-export" {
    source = "github.com/Coalfire-CF/terraform-gcp-log-export"

    destination_uri = module.destination.destination_uri
    filter          = var.log_filter

    log_sink_name          = "org-log-sink"
    parent_resource_id     = "your-org-id"
    parent_resource_type   = "organization"
    include_children       = true
    unique_writer_identity = true
}

module "destination" {
    source = "github.com/Coalfire-CF/terraform-gcp-log-export/modules/pubsub"

    project_id               = google_project.management.project_id
    topic_name               = "org-logs"
    log_sink_writer_identity = module.log_export.writer_identity
    create_subscriber        = true
    kms_key_name             = "kms-key-name"
}
```
