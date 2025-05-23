variable "region" {
  default = "eu-west-3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "AMI Ubuntu 22.04"
  default     = "ami-007c433663055a1cc"
}

variable "key_name" {
  default = "aws-key"
}

variable "public_key" {
  description = "The SSH public key content"
  type        = string
}
