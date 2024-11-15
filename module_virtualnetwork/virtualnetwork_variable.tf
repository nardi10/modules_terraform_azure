variable "virtual_network_range" {
  type = list(any)
}

variable "virtual_network_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "tags" {
  type = map(any)
}

variable "dns_servers" {
  type = list(any)
  default = [ 
   "YOUR-DNS"
   ]
}
