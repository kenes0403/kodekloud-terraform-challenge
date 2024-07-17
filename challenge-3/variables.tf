variable ami {
  type        = string
  default     = "ami-06178cf087598769c"
  description = "Ami"
}

variable region {
    type = string
    default = "eu-west-2"
    description = "Region"
}

variable instance_type {
    type = string
    default = "m5.large"
    description = "Instance"
}
