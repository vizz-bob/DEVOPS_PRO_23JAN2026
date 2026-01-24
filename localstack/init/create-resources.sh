#!/bin/bash
# Script to create SQS queues and SNS topics in LocalStack

echo "Creating SQS queues..."
awslocal sqs create-queue --queue-name order-queue
awslocal sqs create-queue --queue-name payment-queue
awslocal sqs create-queue --queue-name inventory-queue

echo "Creating SNS topics..."
awslocal sns create-topic --name order-topic
awslocal sns create-topic --name payment-topic
awslocal sns create-topic --name inventory-topic

echo "✅ LocalStack resources created!"

