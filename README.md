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
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_logging_billing_account_sink.sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_billing_account_sink) | resource |
| [google_logging_folder_sink.sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_folder_sink) | resource |
| [google_logging_organization_sink.sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_organization_sink) | resource |
| [google_logging_project_sink.sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_uri"></a> [destination\_uri](#input\_destination\_uri) | The self\_link URI of the destination resource (This is available as an output coming from one of the destination submodules) | `string` | n/a | yes |
| <a name="input_exclusions"></a> [exclusions](#input\_exclusions) | (Optional) A list of sink exclusion filters. | <pre>list(object({<br>    name        = string,<br>    description = string,<br>    filter      = string,<br>    disabled    = bool<br>  }))</pre> | `[]` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | The filter to apply when exporting logs. Only log entries that match the filter are exported. Default is '' which exports all logs. | `string` | `""` | no |
| <a name="input_include_children"></a> [include\_children](#input\_include\_children) | Only valid if 'organization' or 'folder' is chosen as var.parent\_resource.type. Determines whether or not to include children organizations/folders in the sink export. If true, logs associated with child projects are also exported; otherwise only logs relating to the provided organization/folder are included. | `bool` | `false` | no |
| <a name="input_log_sink_name"></a> [log\_sink\_name](#input\_log\_sink\_name) | The name of the log sink to be created. | `string` | n/a | yes |
| <a name="input_parent_resource_id"></a> [parent\_resource\_id](#input\_parent\_resource\_id) | The ID of the GCP resource in which you create the log sink. If var.parent\_resource\_type is set to 'project', then this is the Project ID (and etc). | `string` | n/a | yes |
| <a name="input_parent_resource_type"></a> [parent\_resource\_type](#input\_parent\_resource\_type) | The GCP resource in which you create the log sink. The value must not be computed, and must be one of the following: 'project', 'folder', 'billing\_account', or 'organization'. | `string` | `"project"` | no |
| <a name="input_unique_writer_identity"></a> [unique\_writer\_identity](#input\_unique\_writer\_identity) | Whether or not to create a unique identity associated with this sink. If false (the default), then the writer\_identity used is serviceAccount:cloud-logs@system.gserviceaccount.com. If true, then a unique service account is created and used for the logging sink. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_filter"></a> [filter](#output\_filter) | The filter to be applied when exporting logs. |
| <a name="output_log_sink_resource_id"></a> [log\_sink\_resource\_id](#output\_log\_sink\_resource\_id) | The resource ID of the log sink that was created. |
| <a name="output_log_sink_resource_name"></a> [log\_sink\_resource\_name](#output\_log\_sink\_resource\_name) | The resource name of the log sink that was created. |
| <a name="output_parent_resource_id"></a> [parent\_resource\_id](#output\_parent\_resource\_id) | The ID of the GCP resource in which you create the log sink. |
| <a name="output_writer_identity"></a> [writer\_identity](#output\_writer\_identity) | The service account that logging uses to write log entries to the destination. |
<!-- END_TF_DOCS -->
