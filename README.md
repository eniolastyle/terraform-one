# Terraform AWS EC2 Example

This Terraform project creates two EC2 instances and a load balancer in front of them, with Nginx installed on Instance A and Apache installed on Instance B.
It is expected that you have you AWS secrets configured on your system.

## Usage

1. Clone this repository:

git clone https://github.com/username/terraform-aws-ec2-example.git

2. Change into the project directory:

cd terraform-aws-ec2-example

3. Create a `terraform.tfvars` file to define your variables:

region = "us-east-1"
key_name = "your-keypair-name"
s3_bucket_name = "your-tfstate-bucket-name"

4. Initialize the Terraform project:

terraform init -backend-config="bucket=${s3_bucket_name}"

5. Preview the changes that Terraform will make:

terraform plan -var-file="terraform.tfvars"

6. Apply the changes to create the resources:

terraform apply -var-file="terraform.tfvars"

7. When you're finished with the resources, destroy them:

terraform destroy -var-file="terraform.tfvars"

## Variables

The following variables can be defined in your `terraform.tfvars` file:

| Variable       | Description                                      | Type   |
| -------------- | ------------------------------------------------ | ------ |
| access_key     | AWS access key                                   | string |
| secret_key     | AWS secret key                                   | string |
| region         | AWS region where resources will be created       | string |
| key_name       | Name of an existing key pair in your AWS account | string |
| s3_bucket_name | Name of an S3 bucket to store Terraform state    | string |

If you have any further clarification, kindly reach out to me with the below information.

## Author

Lawal Eniola Abdullateef  
Twitter: [@eniolaamiola\_](https://twitter.com/eniolaamiola_)
