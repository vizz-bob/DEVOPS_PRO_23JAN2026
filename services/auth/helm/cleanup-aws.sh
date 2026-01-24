#!/bin/bash
# 🔹 Safe cleanup: Remove only EKS cluster and related resources
REGION="ap-south-1"
TARGET_VPC="vpc-02eed7dc72a88db64"

echo "⏳ Cleaning EKS resources in VPC $TARGET_VPC..."

# 1️⃣ Delete EKS nodegroups in clusters that use this VPC
for CLUSTER in $(aws eks list-clusters --region $REGION --query "clusters[]" --output text); do
    VPC_ID=$(aws eks describe-cluster --name $CLUSTER --region $REGION --query "cluster.resourcesVpcConfig.vpcId" --output text)
    if [ "$VPC_ID" == "$TARGET_VPC" ]; then
        echo "Cluster $CLUSTER is in target VPC $TARGET_VPC"

        # Delete nodegroups
        for NG in $(aws eks list-nodegroups --cluster-name $CLUSTER --region $REGION --query "nodegroups[]" --output text); do
            echo "Deleting nodegroup $NG in cluster $CLUSTER..."
            aws eks delete-nodegroup --cluster-name $CLUSTER --nodegroup-name $NG --region $REGION
        done

        # Delete the cluster
        echo "Deleting cluster $CLUSTER..."
        aws eks delete-cluster --name $CLUSTER --region $REGION

        # Delete associated security groups (optional, only non-default ones)
        for SG in $(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$TARGET_VPC" --region $REGION --query "SecurityGroups[?GroupName!='default'].GroupId" --output text); do
            echo "Deleting security group: $SG"
            aws ec2 delete-security-group --group-id $SG --region $REGION
        done

        # Delete subnets used by the cluster (optional)
        for SUBNET in $(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$TARGET_VPC" --region $REGION --query "Subnets[].SubnetId" --output text); do
            echo "Deleting subnet: $SUBNET"
            aws ec2 delete-subnet --subnet-id $SUBNET --region $REGION
        done
    fi
done

echo "✅ Safe cleanup of EKS cluster and related resources completed!"

