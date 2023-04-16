variable "public_key" {
  description = "terraform one pub key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "terraform one region"
  type        = string
}

variable "s3_bucket_name" {
  description = "terraform tfstate bucket"
  type        = string
}

variable "key_name" {
  description = "key name"
  type        = string
}
