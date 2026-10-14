FROM mcr.microsoft.com/azure-cli:latest

# Install dependencies, Terraform, and cloud auditing tools
RUN tdnf check-update || true && \
    tdnf install -y unzip git jq python3-pip tar gzip which shadow-utils || \
    (apk update && apk add --no-cache curl unzip git jq python3 py3-pip bash) || true

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip -q /tmp/terraform.zip -d /usr/local/bin/ && \
    rm -f /tmp/terraform.zip

# Install Checkov and cloud audit tools
RUN pip3 install --no-cache-dir checkov scoutsuite || pip3 install --no-cache-dir --break-system-packages checkov scoutsuite || true

# Clone AzureGoat vulnerable infrastructure blueprints
WORKDIR /azuregoat
RUN git clone --depth 1 https://github.com/ine-labs/AzureGoat.git /azuregoat/repo || mkdir -p /azuregoat/repo

WORKDIR /workspace

ENV TF_IN_AUTOMATION=1
CMD ["/bin/bash"]
