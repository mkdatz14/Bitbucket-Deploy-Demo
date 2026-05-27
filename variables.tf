variable "tfe_hostname" {
  description = "HCP Terraform or Terraform Enterprise hostname."
  type        = string
  default     = "app.terraform.io"
}

variable "tfe_organization" {
  description = "Target HCP Terraform organization name."
  type        = string
}

variable "oauth_client_name" {
  description = "Display name for the Bitbucket VCS provider in HCP Terraform."
  type        = string
  default     = "bitbucket-data-center-oauth"
}

variable "bitbucket_service_provider" {
  description = "VCS provider type. Prefer bitbucket_data_center. bitbucket_server is legacy and deprecated."
  type        = string
  default     = "bitbucket_data_center"

  validation {
    condition     = contains(["bitbucket_data_center", "bitbucket_server"], var.bitbucket_service_provider)
    error_message = "bitbucket_service_provider must be bitbucket_data_center or legacy bitbucket_server."
  }
}

variable "bitbucket_http_url" {
  description = "User-facing Bitbucket URL. Include the context path if your instance uses one."
  type        = string
}

variable "bitbucket_api_url" {
  description = "Bitbucket API base URL. For instances with a context path, this is often the host root without that path."
  type        = string
}

variable "bitbucket_oauth_consumer_key" {
  description = "Consumer key from the Bitbucket Application Link used by HCP Terraform."
  type        = string
  sensitive   = true
}

variable "bitbucket_oauth_secret" {
  description = "Private key text associated with the Bitbucket Application Link."
  type        = string
  sensitive   = true
}

variable "bitbucket_rsa_public_key" {
  description = "Public key text associated with the Bitbucket Application Link."
  type        = string
  sensitive   = true
}

variable "bitbucket_ssh_private_key" {
  description = "Private SSH key HCP Terraform uses to clone the Bitbucket repository."
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "Display name for the SSH key stored in HCP Terraform."
  type        = string
  default     = "bitbucket-clone-key"
}

variable "workspace_name" {
  description = "Name of the example HCP Terraform workspace to create."
  type        = string
  default     = "bitbucket-example-workspace"
}

variable "workspace_description" {
  description = "Description for the example HCP Terraform workspace."
  type        = string
  default     = "Workspace connected to Bitbucket through a Terraform-managed VCS provider."
}

variable "workspace_auto_apply" {
  description = "Whether the example workspace should auto-apply successful runs."
  type        = bool
  default     = false
}

variable "workspace_terraform_version" {
  description = "Terraform version or version constraint for the example workspace."
  type        = string
  default     = "1.15.5"
}

variable "workspace_working_directory" {
  description = "Working directory inside the Bitbucket repository. Use . for the repo root."
  type        = string
  default     = "."
}

variable "repository_identifier" {
  description = "Bitbucket repository identifier in <project>/<repository> format."
  type        = string
}

variable "repository_branch" {
  description = "Branch the HCP Terraform workspace should watch."
  type        = string
  default     = "main"
}