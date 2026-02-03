variable "instance_type"{
  description = "The AWS instance type to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0786adace1541ca80"  # Ubuntu Server 24.04 LTS (HVM), SSD
}