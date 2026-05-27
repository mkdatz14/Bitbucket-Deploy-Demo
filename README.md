# Bitbucket-Deploy-Demo

Sample Terraform configuration and setup notes for creating an HCP Terraform VCS connection to Bitbucket Server or Bitbucket Data Center.

This demo is intentionally narrower than the previous CI example. It focuses on the HCP Terraform side of the integration:

- create the Bitbucket VCS provider with `tfe_oauth_client`
- add the SSH private key HCP Terraform will use to clone repositories
- create one example workspace connected to a Bitbucket repository through `vcs_repo`

## Important compatibility note

HashiCorp now documents this integration as Bitbucket Data Center, and the current provider examples use `service_provider = "bitbucket_data_center"`.

Bitbucket Server is deprecated by Atlassian, and HashiCorp documents the old `bitbucket_server` provider type as deprecated. If you still run Bitbucket Server, treat this example as a legacy starting point and prefer migrating to Bitbucket Data Center or Bitbucket Cloud.

## Files in this demo

- `versions.tf`: Terraform and provider version constraints.
- `main.tf`: the provider, OAuth client, SSH key, and example workspace.
- `variables.tf`: required inputs for the HCP Terraform organization and Bitbucket connection.
- `outputs.tf`: IDs and URLs that are safe to inspect after apply.
- `terraform.tfvars.example`: placeholder values for local testing.

## What the example creates

1. One `tfe_oauth_client` using the Bitbucket Data Center service provider.
2. One `tfe_ssh_key` for repository clone access.
3. One `tfe_workspace` wired to a Bitbucket repository through `vcs_repo`.

The example does not create Bitbucket-side application links, repositories, or SSH keys in Bitbucket itself. Those still need to exist before Terraform can apply successfully.

## Bitbucket-side prerequisites

Before you run this configuration, complete the Bitbucket-side setup HashiCorp expects for the VCS provider:

1. Create an Application Link in Bitbucket for HCP Terraform or Terraform Enterprise.
2. Record the consumer key and the application-link key pair that HCP Terraform will use.
3. Create a separate SSH key pair with an empty passphrase for repository clone access.
4. Add that SSH public key to the Bitbucket user account that HCP Terraform will use.
5. Confirm that HCP Terraform can reach the Bitbucket HTTP(S) endpoint and SSH endpoint.

If your Bitbucket instance uses a context path, set the URLs carefully:

- `bitbucket_http_url`: full user-facing URL including the context path.
- `bitbucket_api_url`: base host URL without the context path when HashiCorp's Bitbucket Data Center guidance requires it.

## Required inputs

Set `TFE_TOKEN` in the shell environment before running Terraform.

The example Terraform variables then supply:

- `tfe_organization`: target HCP Terraform organization.
- `bitbucket_http_url`: Bitbucket base URL used by browsers.
- `bitbucket_api_url`: Bitbucket API base URL.
- `bitbucket_oauth_consumer_key`: consumer key from the Bitbucket Application Link.
- `bitbucket_oauth_secret`: private key text associated with that Application Link.
- `bitbucket_rsa_public_key`: public key text associated with that Application Link.
- `bitbucket_ssh_private_key`: private SSH key HCP Terraform should use for cloning.
- `repository_identifier`: Bitbucket repository identifier in `<project>/<repository>` format.

## Example workflow

```bash
cp terraform.tfvars.example terraform.tfvars
export TFE_TOKEN="..."
terraform init
terraform plan
terraform apply
```

After apply, the workspace should appear in HCP Terraform with a VCS connection that points at your Bitbucket repository and reuses the OAuth client created by this example.

## Security notes

- `TFE_TOKEN`, `bitbucket_oauth_secret`, and `bitbucket_ssh_private_key` are sensitive.
- Keep `terraform.tfvars` out of version control.
- The current example uses the standard `key` field on `tfe_ssh_key` for compatibility with Terraform versions older than 1.11, which means the SSH private key is stored in state.
- Treat access to local or remote Terraform state as access to the Bitbucket clone credential.

## Provider note

This example is written against `hashicorp/tfe` `~> 0.77.0`, which is the current version reflected in the public registry docs retrieved during this refactor. The local management repository in this workspace still pins an older `0.76.x` line, so keep versions aligned if you later merge patterns between the two directories.
