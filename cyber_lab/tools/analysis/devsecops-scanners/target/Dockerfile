# INSECURE DOCKERFILE - Target for Trivy Misconfig / Container Scanning
# 1. Outdated base image with known CVEs
FROM python:3.9-alpine

# 2. Hardcoded secret inside build environment
ENV ADMIN_TOKEN="super_secret_build_token_xyz123"

# 3. Running as root (no USER directive)
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .

EXPOSE 5000

# 4. Insecure root execution
CMD ["python", "app.py"]
