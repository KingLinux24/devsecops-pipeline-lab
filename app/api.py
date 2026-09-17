import os
import random
import sys

# INTENTIONAL SAST FLAVORS FOR BANDIT / GITLEAKS TESTING

# 1. Hardcoded Secret / API Key
AWS_SECRET_ACCESS_KEY = "AKIAIOSFODNN7EXAMPLE_SECRET_KEY_DO_NOT_USE"
DATABASE_PASSWORD = "SuperSecretPassword123!"

def process_user_input(user_supplied_code):
    print("Executing dynamic evaluation...")
    # 2. Dangerous eval usage (Bandit B307)
    return eval(user_supplied_code)

def generate_insecure_token():
    # 3. Weak pseudo-random generator for security context (Bandit B311)
    session_token = random.randint(100000, 999999)
    return session_token

if __name__ == "__main__":
    print(f"Token: {generate_insecure_token()}")
