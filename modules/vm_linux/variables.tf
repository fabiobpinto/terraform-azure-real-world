variable "rg_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "vm_name" {
  type        = string
  description = "The name of the Linux virtual machine."
}

variable "vm_size" {
  type        = string
  description = "The size of the Linux virtual machine."
}

variable "admin_username" {
  type        = string
  description = "The admin username for the Linux virtual machine."
}

variable "admin_pass" {
  type        = string
  description = "The admin password for the Linux virtual machine."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the network interface will be created."
}

variable "private_ip_address" {
  type        = string
  description = "The static private IP address to assign to the network interface."
}

variable "publisher" {
  type        = string
  description = "The publisher of the OS image."
}

variable "offer" {
  type        = string
  description = "The offer of the OS image."
}

variable "sku" {
  type        = string
  description = "The SKU of the OS image."
}

variable "version" {
  type        = string
  description = "The version of the OS image."
}