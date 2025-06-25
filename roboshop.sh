#!/bin/bash
# This script creates EC2 instances for a Roboshop application and updates Route 53 DNS records.

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0afb0733333250162" # replace with your SG ID
ZONE_ID="Z08186589VBOFNQARTE2" # replace with your ZONE ID
DOMAIN_NAME="akashabalaji.site" # replace with your domain

# Use command line arguments to specify instances
for instance in "$@"
do
    # Launch EC2 instance
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --instance-type t3.micro \
        --security-group-ids "$SG_ID" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query "Instances[0].InstanceId" \
        --output text)

    # Wait for the instance to be running
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    if [ "$instance" != "frontend" ]; then
        # Get private IP for backend services
        IP=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PrivateIpAddress" \
            --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME"
    else
        # Get public IP for frontend
        IP=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PublicIpAddress" \
            --output text)
        RECORD_NAME="$DOMAIN_NAME"
    fi

    echo "$instance IP address: $IP"

    # Create or update the Route 53 record set
    aws route53 change-resource-record-sets \
        --hosted-zone-id "$ZONE_ID" \
        --change-batch "{
            \"Comment\": \"Creating or Updating a record set for $instance\",
            \"Changes\": [{
                \"Action\": \"UPSERT\",
                \"ResourceRecordSet\": {
                    \"Name\": \"$RECORD_NAME\",
                    \"Type\": \"A\",
                    \"TTL\": 60,
                    \"ResourceRecords\": [{\"Value\": \"$IP\"}]
                }
            }]
        }"
done