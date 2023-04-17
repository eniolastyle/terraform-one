# Terraform with AWS Load Balancer and Ec2
This Terraform project creates two EC2 instances and a load balancer in front of them, with Nginx installed on Instance A and Apache installed on Instance B.
It is expected that you have you AWS secrets configured on your system.

## Output

![Screenshot from 2023-04-16 12-51-17](https://user-images.githubusercontent.com/58726365/232307967-7ae89406-5bf4-4f04-aa36-0cd54edc349b.png)
![Screenshot from 2023-04-16 12-51-08](https://user-images.githubusercontent.com/58726365/232307981-4b8a6aee-1a3a-47a3-9377-e5b59896b531.png)

## Usage

1. Clone this repository:

git clone https://github.com/eniolastyle/terraform-one.git

2. Change into the project directory:

cd terraform-one

3. Create a `terraform.tfvars` file to define your variables:

- region = "us-east-1"
- key_name = "your-keypair-name"
- public_key = "your public key" // Note this should be store as a secret for better security.

4. Initialize the Terraform project:

terraform init -backend-config="bucket=<s3_bucket_name>"

5. Preview the changes that Terraform will make:

terraform plan --var-file="terraform.tfvars"

6. Apply the changes to create the resources:

terraform apply --var-file="terraform.tfvars"

7. When you're finished with the resources, destroy them:

terraform destroy --var-file="terraform.tfvars"

## Variables

The following variables can be defined in your `terraform.tfvars` file:

| Variable   | Description                                      | Type   |
| ---------- | ------------------------------------------------ | ------ |
| access_key | AWS access key                                   | string |
| secret_key | AWS secret key                                   | string |
| region     | AWS region where resources will be created       | string |
| key_name   | Name of an existing key pair in your AWS account | string |
| public_key | Your generated pub key with ssh-keygen           | string |

If you have any further clarification, kindly reach out to me with the below information.

## Author

Lawal Eniola Abdullateef  
Twitter: [@eniolaamiola\_](https://twitter.com/eniolaamiola_)
