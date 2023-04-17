# deploy-text-env-azure
To deploy a Dev environment in Azure using Terraform and GitHub Actions, you can follow the steps below:

Set up an Azure account and create a new Azure AD service principal for your GitHub Action.

Create a new GitHub repository and add your Terraform files to it.

In the root of your Terraform repository, create a new file called "main.tf". This file should contain the provider configuration and the resources that you want to deploy to your Dev environment:
