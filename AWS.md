
Creating VPC using AWS CLI
# Create VPC
aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyCompanyVPC}]'

# Enable DNS hostnames
aws ec2 modify-vpc-attribute \
    --vpc-id vpc-12345678 \
    --enable-dns-hostnames
# Create Public Subnet
aws ec2 create-subnet \
    --vpc-id vpc-0f9f9a149c7448994 \
    --cidr-block 10.0.1.0/24 \
    --availability-zone us-east-2a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Public-Subnet-A}]'



# Create Private Subnet
aws ec2 create-subnet \
    --vpc-id vpc-0f9f9a149c7448994 \
    --cidr-block 10.0.10.0/24 \
    --availability-zone us-east-2a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Private-Subnet-A}]'
