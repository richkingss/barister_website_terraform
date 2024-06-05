variable "cluster_name" {
  description = ""
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "URL of the container image"
  type        = string
}