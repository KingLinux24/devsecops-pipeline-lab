# Automated DevSecOps CI/CD Pipeline & Static Analysis

A shift-left security telemetry and automated code analysis laboratory built with **GitHub Actions**. This project demonstrates pre-deployment static application security testing (SAST), Infrastructure-as-Code (IaC) security auditing, and automated secret detection to stop vulnerabilities and cloud misconfigurations before deployment.

---

## 🏗️ Pipeline Architecture

```text
[ Developer Push / PR ] ──► [ GitHub Repository ]
                                    │
                                    ▼
                       [ GitHub Actions Pipeline ]
                                    │
     ┌──────────────────────────────┼──────────────────────────────┐
     ▼                              ▼                              ▼
[ SAST: Bandit ]           [ IaC Scan: Checkov ]        [ Secret Scan: Gitleaks ]
(Python Security)         (Terraform Security)           (Credential Detection)
     │                              │                              │
     └──────────────────────────────┼──────────────────────────────┘
                                    │
                           [ Quality Gate Check ]
                           (Audit & Security Flags)
🛡️ Integrated Security Scanners
Python SAST (Bandit): Inspects Python application code (app/) for unsafe code patterns including dynamic evaluation (eval()), hardcoded credentials, and weak pseudo-random number generators (PRNG).

IaC Security (Checkov): Audits Terraform infrastructure definitions (terraform/) for AWS security misconfigurations, such as unencrypted S3 buckets, public access policies, and overly permissive inbound Security Group rules (0.0.0.0/0 on SSH).

Secret Detection (Gitleaks): Scans git commit history and source code for exposed API keys, high-entropy strings, and hardcoded AWS credentials.

📂 Repository Structure
Plaintext
devsecops-pipeline-lab/
├── .github/
│   └── workflows/
│       └── devsecops-pipeline.yml   # Main GitHub Actions CI/CD security workflow
├── app/
│   └── api.py                       # Python test target (SAST security flaws)
├── terraform/
│   └── main.tf                      # Terraform test target (IaC misconfigurations)
├── scripts/                         # Security automation & reporting scripts
└── README.md                        # Portfolio documentation
🧪 Simulated Vulnerability Findings
The repository contains intentional pre-deployment security findings used to validate pipeline scanner coverage:

1. Application Security (app/api.py)
B307 (eval usage): Dynamic execution of user input.

B105 / B106 (Hardcoded Credentials): Hardcoded secrets/passwords assigned directly in source code.

B311 (Insecure Randomness): Standard random library usage in a security context.

2. Infrastructure-as-Code (terraform/main.tf)
CKV_AWS_18 / CKV_AWS_21: Missing S3 bucket server-side encryption and versioning.

CKV_AWS_20: S3 bucket public access block set to permissive levels.

CKV_AWS_24 / CKV_AWS_260: Security Group allowing unrestricted inbound SSH traffic (0.0.0.0/0 on port 22).