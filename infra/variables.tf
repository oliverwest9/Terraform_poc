variable "region" {
  description = "The AWS region to deploy resources in."
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  default = "internal-gpt-front-end"
}

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone."
  default = "internal-gpt.life"
}

variable "index_document" {
  description = "The S3 bucket index document."
  default     = "index.html"
}

variable "error_document" {
  description = "The S3 bucket error document."
  default     = "error.html"
}