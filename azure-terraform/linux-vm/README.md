```sh
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@terraform" \
    -f ./azure-terraform
```