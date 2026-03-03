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

### Security Groups 

A Security Group acts like a virtual firewall that controls inbound (ingress) and outbound (egress) traffic.

```Security Groups```
Creates three layered security groups for a 3-tier architecture:
```
(1) ALB Security Group allows HTTP/HTTPS access from the internet.
(2) Web Tier Security Group allows HTTP/HTTPS traffic only from the ALB.
(3) Database Security Group allows MySQL access only from the Web Tier.
```

```
Internet
↓
ALB
↓
Web Tier (EC2)
↓
Database (RDS)
```

### RDS (Relational Database Service)

This Terraform module provisions an Amazon Aurora MySQL cluster on AWS with a primary instance and a read replica for high availability and improved read scalability.

```aws_db_subnet_group```
Creates a DB subnet group using private subnets to ensure the database is deployed securely within the VPC.

```aws_rds_cluster (Aurora MySQL Cluster)```
Provisions an Amazon Aurora MySQL-compatible cluster with:
```
(1) Configurable database name and credentials.
(2) Automated backups (7-day retention).
(3) Custom backup window.
(4) VPC security group association.
(5) Private subnet placement.
```

```aws_rds_cluster_instance (Primary Instance)```
Creates the main writer instance for handling application read/write traffic.

```aws_rds_cluster_instance (Read Replica)```
Creates a read replica instance to distribute read workloads and improve performance and availability.

### ALB (Application Load Balancer)

This Terraform module provisions a public-facing Application Load Balancer to distribute incoming web traffic across EC2 instances in the web tier.

```aws_lb (Application Load Balancer)```
Creates a public AWS Application Load Balancer deployed across two public subnets with an associated security group.
```
(1) Internet-facing (internal = false).
(2) IPv4 support.
(3) Deletion protection disabled (can be enabled for production).
```
```aws_lb_target_group (Web Target Group)```
Defines a target group that routes traffic to EC2 instances on port 80.
```
(1) HTTP health checks enabled (/ path).
(2) Custom health check interval and thresholds.
(3) Attached to the specified VPC.
```

```aws_lb_listener (HTTP Listener)```
Configures a listener on port 80 (HTTP) that forwards incoming requests to the web target group.

### IAM (Identity and Access Management)

This Terraform module provisions an IAM role and instance profile to securely grant permissions to EC2 instances.

```aws_iam_role (IAM Role)```
Creates an IAM role with a custom trust policy (iam-role.json) that defines which service (e.g., EC2) can assume the role.

```aws_iam_role_policy (Inline Policy)```
Attaches a custom inline policy (iam-policy.json) to the role, defining the specific AWS permissions required by the instance.

```aws_iam_instance_profile (Instance Profile)```
Creates an instance profile that allows the IAM role to be attached to EC2 instances.

### Autoscaling

This Terraform module provisions a scalable and self-healing web tier using an Auto Scaling Group integrated with load balancing and CloudWatch monitoring.

```aws_launch_template (Launch Template)```
Defines the EC2 configuration including:
```
(1) AMI ID (Amazon Machine Image)
(2) Instance type (t2.micro)
(3) Security group association
(4) User data script for application deployment
```

```aws_autoscaling_group (ASG)```
Creates an Auto Scaling Group across two public subnets with:
```
(1) Minimum 2 instances, maximum 4 instances
(2) ELB health checks
(3) Target group attachment
(4) Instance tagging
```

```aws_autoscaling_policy (Scale-Up Policy)```
Increases instance count by 1 when triggered.

```aws_cloudwatch_metric_alarm (High CPU Alarm)```
Triggers scale-up when CPU utilization ≥ 70%.

```aws_autoscaling_policy (Scale-Down Policy)```
Decreases instance count by 1 when triggered.

```aws_cloudwatch_metric_alarm (Low CPU Alarm)```
Triggers scale-down when CPU utilization ≤ 50%.

### Route53 

This Terraform module provisions a secure and globally distributed content delivery setup using CloudFront, SSL/TLS certificates, DNS records, and Web Application Firewall protection.

```ACM – SSL Certificate```
```
aws_acm_certificate
aws_acm_certificate_validation
```
Creates and validates an SSL/TLS certificate using DNS validation for the root domain and www subdomain.

Service Used:
```
AWS Certificate Manager
Purpose: Enables HTTPS encryption for secure communication.
```

```CloudFront – Content Delivery Network```
```
aws_cloudfront_distribution
```
Creates a CDN distribution with:
(1) ALB as the origin.
(2) HTTPS enforcement (redirect-to-https).
(3) IPv6 support.
(4) Custom domain aliases.
(5) SSL certificate attachment.
(6) WAF integration.

Service Used:
```
Amazon CloudFront
CDN – Content Delivery Network

Purpose:
(1) Global content caching
(2) Reduced latency
(3) Improved performance and scalability
(4) Secure content delivery
```

```Route 53 – DNS Management```
```
aws_route53_record (certificate validation)
aws_route53_record (www record)
aws_route53_record (apex/root record)
```
```
Creates DNS records for:
(1) Certificate validation
(2) Root domain
(3) www subdomain
```
Service Used:
```
Amazon Route 53
Domain Name System

Purpose:
(1) Maps domain name to CloudFront distribution.
(2) Enables public access to application.
```

```WAF – Web Application Firewall```
```
aws_wafv2_web_acl
```
Creates a Web ACL attached to CloudFront with AWS Managed Rules to block anonymous IP sources (e.g., TOR, VPN users).

Service Used:
```
AWS WAF
WAF – Web Application Firewall

Purpose:
(1) Protects against malicious traffic.
(2) Blocks anonymous IP addresses.
(3) Enhances application security.