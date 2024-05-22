## SP
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

```
az login
az account set --subscription="c344bf80-ed9d-4630-b1a7-4c9d3225a111"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/c344bf80-ed9d-4630-b1a7-4c9d3225a111" --name "s6-auth"

{
  "appId": "6c726a0e-f0c8-4edf-a2a3-382fecaedcf6",
  "displayName": "s6-auth",
  "password": "~AL8Q~aXRgx5kqymp_1w.bZFsuLlBveLbrD8VcXw",
  "tenant": "a5e4db0a-c014-45e6-a834-327edf475b29"
}

az login --service-principal -u "b7fd72cd-7f2c-48c1-86b2-70af5764ebe8" -p "LEU8Q~-jhdGBa1kAwC3LouX4HUB3KX3iyo4sqbQb" --tenant "a5e4db0a-c014-45e6-a834-327edf475b29"
```

