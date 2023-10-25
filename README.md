# aws-network

Components:
- VPC
- public subnets
- private subnets
- nat gateways for private subnets
- igw
- route tables for each subnet
- routes from public subnets to igw
- routes from private subnets to nat gateways; one-to-one mapping
- route table associations to link each route table to a subnet

See [here](https://github.com/friends-ce-3-group/terraform-aws-network/blob/main/testing/main.tf) for example usage.