 fo# Component Descriptions

%Write a short summary of whats comming.

A descriptions of the security requisits of each service that could not been shown in the diagram
## General security Requiremets
- Use CRUD models for Deployment to ensure they are Deployded following the Security Requirements
- Capture resources logs and send them to a SIEM/SOAR
- Instaurate Security Policies to ensure incorrect configurations cannot be made and monitor resources configuration
- Store secrets, keys and certificates on an EKS
- Establish a rotation policy to rotate secrets, key and certificates regularly
- Follow the principle of least privileged
- TLS is required in all services with a minimum version of 1.2 (1.3 preferrly)
- Data at rest should be encrupted using KMS for managed key encryption.
- Guarduty shoud 
## Service specific Security Requirements
### Autoescale groups
- **CI/CD pipelines** should be in place for the EC2's code using a **shift left approach**
- EC2 instances should be protected by an **EDR** solution
- There should not be credentials hardcoded in the code, instead an **EKM** should be set
- Disk Snapshots should be taken regularely and stored in two different regions
- Daily backups
- For accessing the DB **IAM Roles** with instances profiles should be used, ensuring the principle of least privileged is being met.
### RDS
- **Daily Backups** should be applied
- Regular snapshots into two different regions
### Bastion Host
- Limit Access via IAM Roles
- Implement Multi-Factor Authentication (MFA)



