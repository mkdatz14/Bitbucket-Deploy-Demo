# Bitbucket-Deploy-Demo

Sample Terraform configuration and setup notes for creating an HCP Terraform VCS connection to Bitbucket Data Center.

This demo sets up the integration in HCP Terraform:

- create the Bitbucket VCS provider with `tfe_oauth_client`
- add the SSH private key HCP Terraform will use to clone repositories
- create one example workspace connected to a Bitbucket repository through `vcs_repo`

## Files in this demo

- `versions.tf`: Terraform and provider version constraints.
- `main.tf`: the provider, OAuth client, SSH key, and example workspace.
- `variables.tf`: required inputs for the HCP Terraform organization and Bitbucket connection.
- `outputs.tf`: IDs and URLs that are safe to inspect after apply.
- `terraform.tfvars.example`: placeholder values for local testing.

## What the example documents

1. One `tfe_oauth_client` using the Bitbucket Data Center service provider.
2. One `tfe_ssh_key` for repository clone access.
3. One `tfe_workspace` wired to a Bitbucket repository through `vcs_repo`.

The example does not create Bitbucket-side application links, repositories, or SSH keys in Bitbucket itself. Those still need to exist before Terraform can apply the resources successfully.

## Bitbucket-side prerequisites

Before you run this configuration, complete the Bitbucket-side setup HCP Terraform expects for the VCS provider:

1. Create an Application Link in Bitbucket for HCP Terraform.
2. Record the consumer key and the application-link key pair that HCP Terraform will use.
3. Create a separate SSH key pair with an empty passphrase for repository clone access.
4. Add that SSH public key to the Bitbucket user account that HCP Terraform will use.
5. Confirm that HCP Terraform can reach the Bitbucket HTTP(S) endpoint and SSH endpoint.

For the specified URLs:

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

## Security notes

- `TFE_TOKEN`, `bitbucket_oauth_secret`, and `bitbucket_ssh_private_key` are sensitive.
- Keep `terraform.tfvars` out of version control.
- The current example uses the standard `key` field on `tfe_ssh_key` for compatibility with Terraform versions older than 1.11, which means the SSH private key is stored in state.
- Treat access to local or remote Terraform state as access to the Bitbucket clone credential.
