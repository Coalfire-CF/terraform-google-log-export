# Google Cloud Log Export Storage Destination Terraform Module

This module allows you to configure a Storage bucket destination that can be used by the log export module.
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
| [google_project_service.enable_destination_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.storage_sink_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_locations"></a> [data\_locations](#input\_data\_locations) | Configuration of the bucket's custom location in a dual-region bucket setup. If the bucket is designated a single or multi-region, then the variable will be null. Note: If any of the data\_locations changes, it will recreate the bucket. | `list(string)` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When deleting a bucket, this boolean option will delete all contained objects. | `bool` | `false` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | ID of a Cloud KMS key that will be used to encrypt objects inserted into this bucket. Automatic Google Cloud Storage service account for the bucket's project requires access to this encryption key. | `string` | `null` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches\_storage\_class should be a comma delimited string. | <pre>set(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = map(string)<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    # - days_since_custom_time - (Optional) The number of days from the Custom-Time metadata attribute after which this condition becomes true.<br>    condition = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the storage bucket. | `string` | `"US"` | no |
| <a name="input_log_sink_writer_identity"></a> [log\_sink\_writer\_identity](#input\_log\_sink\_writer\_identity) | The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module). | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the storage bucket will be created. | `string` | n/a | yes |
| <a name="input_public_access_prevention"></a> [public\_access\_prevention](#input\_public\_access\_prevention) | Prevents public access to a bucket. Acceptable values are "inherited" or "enforced". If "inherited", the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint. | `string` | `"inherited"` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | <pre>object({<br>    is_locked             = bool<br>    retention_period_days = number<br>  })</pre> | `null` | no |
| <a name="input_storage_bucket_labels"></a> [storage\_bucket\_labels](#input\_storage\_bucket\_labels) | Labels to apply to the storage bucket. | `map(string)` | `{}` | no |
| <a name="input_storage_bucket_name"></a> [storage\_bucket\_name](#input\_storage\_bucket\_name) | The name of the storage bucket to be created and used for log entries matching the filter. | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | The storage class of the storage bucket. | `string` | `"STANDARD"` | no |
| <a name="input_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | Enables Uniform bucket-level access to a bucket. | `bool` | `true` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_console_link"></a> [console\_link](#output\_console\_link) | The console link to the destination storage bucket |
| <a name="output_destination_uri"></a> [destination\_uri](#output\_destination\_uri) | The destination URI for the storage bucket. |
| <a name="output_project"></a> [project](#output\_project) | The project in which the storage bucket was created. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource id for the destination storage bucket |
| <a name="output_resource_name"></a> [resource\_name](#output\_resource\_name) | The resource name for the destination storage bucket |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The self\_link URI for the destination storage bucket |
<!-- END_TF_DOCS -->