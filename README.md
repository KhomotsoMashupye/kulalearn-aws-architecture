# 📚 KulaLearn – Scalable AWS Architecture for EdTech Platform

##  Project Overview

*KulaLearn* is a growing EdTech platform serving university and high school learners across East and Southern Africa. The platform offers video lectures, quizzes, live tutoring, and peer discussions via web and mobile apps. As usage increased, the need for a more scalable, secure, and reliable infrastructure became essential.

This architecture diagram represents a modern, serverless AWS-based solution designed to improve performance, resilience, and compliance , while enabling future regional expansion.

---

##  Architecture Components

### User Interaction
- *Users* access the platform via mobile or web apps.

### Content Delivery & Authentication
- *Amazon CloudFront*: Delivers static assets (e.g., video lectures) via edge locations for low-latency access across the region.
- *Amazon Cognito*: Manages user sign-up, sign-in, and access control securely.

### API Management & Backend Logic
- *Amazon API Gateway*: Acts as the front door for all API requests from clients.
- *AWS Lambda*: Handles backend logic, such as:
  - User registration/authentication
  - Quiz processing
  - Session logging
  - Notifications
- *Amazon CloudWatch*: Monitors Lambda functions, collects logs, and triggers alarms for failures.

### Communication & Processing Pipelines
- *Amazon SQS (Simple Queue Service)*: Buffers high-volume requests during peak times (e.g., exams), ensuring smooth backend processing.
- *Amazon SNS (Simple Notification Service)*: Sends push and SMS notifications to students and tutors.

### Storage & Data
- *Amazon S3*: Stores videos, course files, and static web assets.
- *Amazon RDS*: Stores structured data (user records, test results, session logs) in a secure relational database.
- *Amazon Kinesis*: Streams real-time usage data for performance analytics (optional).

### Security & Audit
- *IAM (Identity and Access Management)*: Controls secure access to AWS resources.
- *AWS CloudTrail*: Provides auditing by recording API activity and resource changes.

---



---

## Benefits of This Architecture
- *Scalable*: Serverless and event-driven design handles unpredictable usage spikes.
- *Secure*: Authentication via Cognito, role-based access with IAM, and encrypted data.
- *Compliant*: Aligns with local data protection laws by enabling regional data storage and auditing.
- *Modular*: Each service/component can scale independently or be replaced without affecting the rest of the system.

---

## Repository Contents

| File | Description |
|------|-------------|
| architecture-images | images of the final architect |
| README.md                | This project documentation file |
| Terraform                | The proof of concept (IaC)|
---

## Next Steps / Future Improvements
- Add a *load balancer* or *AWS Global Accelerator* to optimize traffic distribution.
- Integrate *CI/CD pipelines* with AWS CodePipeline and CodeDeploy.
- Expand support for *multi-language content* using Amazon Translate.
- Enable *regional data storage* for POPIA and Uganda compliance.

---




