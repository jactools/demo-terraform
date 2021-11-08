variable subnet_name {
	type = string
}

variable resource_group_name {
	type = string
}

variable vnet_name {
	type = string
}

variable address_prefixes {
	type = list(string)
	default = ["10.0.0.0/24"]
}
