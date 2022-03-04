ENV            = "dev"
VPC_CIDR       = "192.168.0.0/24"
PUBLIC_CIDR    = ["192.168.0.0/26","192.168.0.64/26"]
PRIVATE_CIDR   = ["192.168.0.128/26","192.168.0.192/26"]
IGW_CIDR       = "0.0.0.0/0"
HOSTED_ZONE_ID = "Z06073833HRJH7BROSQ4N"
BACKEND_COMPONENTS = ["catalogue","cart","user","shipping","payment"]