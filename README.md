# 📚 KulaLearn  
### Scalable Serverless AWS Architecture for an EdTech Platform

---

## Project Overview

**KulaLearn** is a proof-of-concept cloud architecture for a scalable EdTech platform serving university and high-school learners across East and Southern Africa.

The project demonstrates how to design and provision a **secure, serverless, multi-AZ AWS environment** capable of supporting video content delivery, API-driven backends, asynchronous processing, and relational data storage — all defined using **Infrastructure as Code (Terraform)**.

This repository focuses on **architecture and infrastructure design**, not application code.

---

## Architecture Summary

The solution uses managed AWS services to achieve scalability, resilience, and operational simplicity while keeping costs predictable.

### High-Level Flow

1. Users access static content via CloudFront.
2. API requests are routed through API Gateway.
3. Backend logic executes in AWS Lambda within a VPC.
4. Asynchronous workloads are handled via SQS and SNS.
5. Persistent relational data is stored in Amazon RDS.
6. Monitoring and logging are handled by CloudWatch.

---

## Architecture Components

### Content Delivery
- **Amazon S3**  
  Stores static assets such as frontend files and media content.

- **Amazon CloudFront**  
  Distributes content globally using edge locations for reduced latency.

### API & Compute
- **Amazon API Gateway (HTTP API)**  
  Serves as the entry point for all client API requests.

- **AWS Lambda (VPC-enabled)**  
  Executes backend business logic in a serverless, event-driven manner while maintaining network isolation.

- **Amazon CloudWatch**  
  Centralized logging and monitoring for Lambda execution and system health.

### Messaging & Event Handling
- **Amazon SQS**  
  Buffers background tasks and smooths traffic spikes during peak usage.

- **Amazon SNS**  
  Enables fan-out notifications and event broadcasting between services.

### Data Layer
- **Amazon RDS (MySQL)**  
  Stores structured application data such as users, sessions, and academic records.  
  Deployed in **private subnets across multiple Availability Zones** for resilience.

### Networking & Security
- **Amazon VPC**  
  Isolated network environment with public and private subnets across multiple AZs.

- **NAT Gateway & Internet Gateway**  
  Enables controlled outbound internet access for private resources.

- **IAM Roles & Policies**  
  Enforces least-privilege access across all services.

---

## Repository Structure

```text
kula-learn-terraform/
├── main.tf                 # Core infrastructure resources
├── provider.tf             # AWS provider configuration
├── variables.tf            # Input variables
├── outputs.tf              # Exported infrastructure outputs
├── architecture-images/    # Architecture diagrams
│   ├── vpc-diagram.png
│   ├── lambda-flow.png
│   └── messaging-database.png
├── README.md               # Project documentation

---
Benefits of this architecture
- Scalable:
  Leveraging serverless and event-driven services to automatically handle variable workloads.

- Secure:
  Network isolation, IAM-based access control, and private databases protect sensitive data.

- Highly Available:
  Multi-AZ deployment ensures resilience and reduces the risk of downtime.

- Maintainable:
  Fully defined as code using Terraform, making updates and reproducibility simple.

- Production-Ready:
  Follows real-world AWS architecture patterns suitable for enterprise workloads.


