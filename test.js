// - name: Terraform Init
//         run: terraform init -backend-config="bucket=$TF_STATE_BUCKET_NAME"
//       - name: Terraform apply
//         run: |
//           terraform apply \
//           -var-file=terraform.tfvars \
//           -var="public_key=$PUBLIC_SSH_KEY" \