name: Deploy Terraform in Azure

on:
  push:
    branches:
      - main

env:
  ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
  ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
  ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
  credentials: ${{ toJson({
    "clientId": "${{ secrets.AZURE_CLIENT_ID }}",
    "clientSecret": "${{ secrets.AZURE_CLIENT_SECRET }}",
    "subscriptionId": "${{ secrets.AZURE_SUBSCRIPTION_ID }}",
    "tenantId": "${{ secrets.AZURE_TENANT_ID }}"
  }) }}

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v2
    - name: Setup Azure CLI
      uses: azure/setup-azure-cli@v1
      with:
        azcliversion: 2.25.0
    - name: Login to Azure
      uses: azure/login@v1
      with:
        creds: '${{ fromJson(env.credentials) }}'
    - name: Terraform Init
      run: terraform init
      working-directory: ./terraform
    - name: Terraform Validate
      run: terraform validate
      working-directory: ./terraform
    - name: Terraform Plan
      run: terraform plan
      working-directory: ./terraform
    - name: Terraform Apply
      run: terraform apply --auto-approve
      working-directory: ./terraform
