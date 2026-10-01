variable "resource_group_name" {
  type    = string
  default = "task2-resources"
}

variable "location" {
  type    = string
  default = "Denmark East"
}

variable "storage_account_name" {
  type    = string
  default = "storageaccfedoruk"
}

variable "container_name" {
  type    = string
  default = "code-container"
}

variable "blob_name" {
  type    = string
  default = "terraform_code.zip"
}
