## Two Tier AWS Infrastructure Using Terraform 

Built a modular, production-ready AWS infrastructure using Terraform, featuring a secure VPC architecture, Auto Scaling Group behind an Application Load Balancer, and Amazon RDS deployed in private subnets. Implemented CloudFront, Route 53, ACM, and AWS WAF to ensure high availability, performance optimization, and strong security across the stack.

### Two Tier Infrastructure 

A two-tier infrastructure is an architecture where an application is divided into two layers: the application tier (which handles user interface and business logic) and the database tier (which manages data storage). The application server communicates directly with the database, while users interact only with the application layer.

## Modules 

### VPC(Virtual Private Cloud)

A Virtual Private Cloud (VPC) is a secure, isolated, and logically defined private network hosted within a public cloud provider's infrastructure.

```VPC```
Creating a VPC setting up a private IP address range, allowing instances in the VPC to receive DNS hostnames and enabling DNS resolution inside the VPC.

```Internet Gateway``` 
Creating an internet gateway and attaching it to the VPC. Internet gateway basically allows our VPC to communicate to the public internet.

```Public Subnets```
Creates two public subnets in different Availability Zones within the VPC, configured to automatically assign public IPs to instances.

```Private Subnets```
Creates two private subnets in different Availability Zones within the VPC, configured not to assign public IPs to instances.
This setup is used to securely host internal resources like RDS databases that should not be directly accessible from the internet, while maintaining high availability across multiple AZs.

```Elastic IPs for NAT Gateway```
Elastic IPs provide fixed public IP addresses that allow instances in private subnets to access the internet without being directly exposed to inbound internet traffic.

```NAT(Network Address Translation) Gateway```
Creating NAT Gateways in public subnets and associates them with Elastic IPs. This allows instances in private subnets to securely access the internet. NAT gateways do need an internet gateway to get access to the public internet.

```Route Table```
Creating a public route table that allows instances in associated subnets to send and receive internet traffic through the Internet Gateway.

```Route Table Association```
This ensures that the subnet follows the routing rules defined in that route table, allowing its instances to access the internet.