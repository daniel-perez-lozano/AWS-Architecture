# Security Requirements

This document outlines the **security requirements** for various services in the architecture, including general security practices and service-specific guidelines to ensure the application is secure, resilient, and compliant with best practices.

---

## **General Security Requirements**
- Use **CRUD models** for deployment to ensure security best practices are followed.
- Use **CloudWatch** or another centralized logging system to capture and monitor logs for all resources.
- Integrate logs into a **SIEM/SOAR** solution for automated incident detection and response.
- Implement **security policies** to prevent incorrect configurations and monitor resource settings.
- Store **secrets**, **keys**, and **certificates** in **EKM**.
- Establish a **rotation policy** for **secrets**, **keys**, and **certificates**.
- Follow the **principle of least privilege** and perform regular **access reviews**.
- **TLS** (minimum version 1.2, preferably 1.3) is required across all services.
- **Data at rest** must be encrypted using **KMS** for managed key encryption.
- Enable **GuardDuty** for all resources.
- Ensure a **Disaster Recovery Plan** with established **RTO** and **RPO**.
- Use **AWS CloudTrail** to audit and investigate security incidents.

## **Service-Specific Security Requirements**
### **Auto Scaling Groups**
- Implement **CI/CD pipelines** for EC2 code using a **shift-left approach**.
- Protect EC2 instances with an **EDR** solution.
- Avoid hardcoding credentials in the code; instead, use **EKM**.
- Take **disk snapshots** of EC2 instances regularly and store them in two different regions.
- Perform **daily backups**.
- Use **IAM roles** with instance profiles for database access to meet the **principle of least privilege**.
- Enable **JIT access** for updates.
- Ensure an **EDR solution** and a** Vulnerability Management** is running.

### **RDS**
- Apply **daily backups**.
- Regularly take **snapshots** and store them in two different regions.
- Ensure access is only through **IAM roles**.

### **Bastion Host**
- Limit access using **IAM roles**.
- Implement **Multi-Factor Authentication (MFA)** for access.

### **Fargate**
- Use **ECR** and **AKS** for **task** and **pod isolation**, **high availability**, and **auto-scaling**.
- Perform **daily backups**.
- Ensure **Kubernetes** has an **EDR solution** running.
