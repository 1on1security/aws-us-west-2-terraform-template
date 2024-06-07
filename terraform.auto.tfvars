vpc_name           = "My-VPC"
region             = "us-west-2"
availability_zone1 = "us-west-2a"
availability_zone2 = "us-west-2b"
availability_zone3 = "us-west-2c"
vpc_cidr           = "192.168.0.0/24"

public_subnet       = "192.168.0.128/26"
private_subnet      = "192.168.0.192/26"
public_subnet_name  = "public_subnet"
private_subnet_name = "private_subnet"

internet_gateway_name = "InternetGW"

public_route_name  = "public_route"
private_route_name = "private_route"

nat_gateway_name     = "NATgw"
private_gateway_name = "PrivateGW"
eip_name             = "EIP"

# aws ubuntu 22.04 pro us-west-2
# you'll need to search for an image if you want to use alternate region.
public_ami_image  = "ami-0e79c8385235f85b8"
private_ami_image = "ami-0e79c8385235f85b8"

public_server  = "public.mydomain.com"
private_server = "private.mydomain.priv"