FROM python:3.11-slim

# Install system dependencies, AWS CLI, and Terraform
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    git \
    jq \
    groff \
    less \
    bash \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip -d /usr/local/bin/ \
    && rm terraform.zip

# Install AWS CLI v2
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# Set up CloudGoat repository
WORKDIR /cloudgoat
RUN git clone --depth 1 https://github.com/RhinoSecurityLabs/cloudgoat.git /cloudgoat \
    && pip install --no-cache-dir -r requirements.txt

# Create workspace and configuration directories
RUN mkdir -p /cloudgoat/workspace /root/.aws

ENV PYTHONUNBUFFERED=1
ENV PATH="/cloudgoat:${PATH}"

CMD ["/bin/bash"]
