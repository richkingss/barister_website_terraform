variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
  type        = string
}