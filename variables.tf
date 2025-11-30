# VPC
variable "VPC-NAME" {
  description = "Name to assign to the VPC(Virtual Private Cloud)"
}
variable "VPC-CIDR" {
  description = "CIDR block range to assign to the VPC"
}
variable "IGW-NAME" {
  description = "Name to assign to the Internet Gateway"
}
variable "PUBLIC-CIDR1" {
  description = "CIDR block range for the first public subnet"
}
variable "PUBLIC-SUBNET1" {
  description = "Name to assign to the first public subnet"
}
variable "PUBLIC-CIDR2" {
  description = "CIDR block range for the second public subnet"
}
variable "PUBLIC-SUBNET2" {
  description = "Name to assign to the second public subnet"
}
variable "PRIVATE-CIDR1" {
  description = "CIDR block range for the first private subnet"
}
variable "PRIVATE-SUBNET1" {
  description = "Name to assign to the first private subnet"
}
variable "PRIVATE-CIDR2" {
  description = "CIDR block range for the second private subnet"
}
variable "PRIVATE-SUBNET2" {
  description = "Name to assign to the second private subnet"
}
variable "EIP-NAME1" {
  description = "Name to assign to the first elastic IP"
}
variable "EIP-NAME2" {
  description = "Name to assign to the second elastic IP"
}
variable "NGW-NAME1" {
  description = "Name to assign to the first network gateway"
}
variable "NGW-NAME2" {
  description = "Name to assign to the second network gateway"
}
variable "PUBLIC-RT-NAME1" {
  description = "Name to assign to the first public route table"
}
variable "PUBLIC-RT-NAME2" {
  description = "Name to assign to the second public route table"
}
variable "PRIVATE-RT-NAME1" {
  description = "Name to assign to the first private route table"
}
variable "PRIVATE-RT-NAME2" {
  description = "Name to assign to the second private route table"
}

# SECURITY GROUP
variable "ALB-SG-NAME" {
  description = "Name to assign to the security group for the ALB"
}
variable "WEB-SG-NAME" {
  description = "Name to assign to the security group for the web servers"
}
variable "DB-SG-NAME" {
  description = "Name to assign to the security group for the database servers"
}

# RDS
variable "SG-NAME" {
  description = "Name to assign to the the security groups for the RDS instance"
}
variable "RDS-USERNAME" {
  description = "Username for the RDS database"
}
variable "RDS-PWD" {
  description = "Password for the RDS database user"
}
variable "DB-NAME" {
  description = "Name of the databse to create in RDS"
}
variable "RDS-NAME" {
  description = "Identifier/Name for the RDS instance"
}



# ALB
variable "TG-NAME" {
  description = "Name of the target group for the application load balancer"
}
variable "ALB-NAME" {
  description = "Name to assign to the application load balancer"
}

# IAM
variable "IAM-ROLE" {
  description = "Name of the IAM role to create or attach"
}
variable "IAM-POLICY" {
  description = "Name of the IAM policy to attach to the role"
}
variable "INSTANCE-PROFILE-NAME" {
  description = "Name of the IAM instance profile for EC2 instances"
}

# AUTOSCALING
# AMI (Amazon Machine Image) Custom image with pre baked configurations
variable "AMI-NAME" {
  description = "Name of ID of AMI to use for launching instances"
}
variable "LAUNCH-TEMPLATE-NAME" {
  description = "Name of the launch template for the auto scaling group"
}
variable "ASG-NAME" {
  description = "Name of the auto scaling group"
}

# CLOUDFFRONT
variable "DOMAIN-NAME" {
  description = "Domain name to associate with the CloudFront distribution"
}
variable "CDN-NAME" {
  description = "Name to assign to the CloudFront distribution"
}

# WAF
variable "WEB-ACL-NAME" {
  description = "Name of the web ACL(Access Control List) for AWS WAF(Web Application Firewall) to protect resources"
}

