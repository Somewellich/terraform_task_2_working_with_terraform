
resource "azurerm_resource_group" "task2" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "task2" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.task2.name
  location                 = azurerm_resource_group.task2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "task2" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.task2.name
  container_access_type = "private"
}

data "archive_file" "terraform_package" {
  type        = "zip"
  source_dir  = path.module
  output_path = "${path.module}/${var.blob_name}"
  excludes = [
    var.blob_name,
    "tfplan",
    ".terraform",
    ".terraform.lock.hcl",
    "terraform.tfstate",
    "terraform.tfstate.backup",
    ".git"
  ]
}

resource "azurerm_storage_blob" "task2" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.task2.name
  storage_container_name = azurerm_storage_container.task2.name
  type                   = "Block"
  source                 = data.archive_file.terraform_package.output_path
}