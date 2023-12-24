# Use the official Ubuntu image as a base
FROM ubuntu

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    vim \
    openssh-client \
    gnupg \
    software-properties-common \
    lsb-release \
    zsh \
    silversearcher-ag \
    python3.10 \
    python3-pip \
    python3-venv \
    zip

# Install AWS CLI for ARM64
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg && \
    mv hashicorp.gpg /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform

# Create a new user 'user' and add him to the 'sudo' group
RUN useradd -m user -s /bin/zsh && \
    echo 'user:user' | chpasswd && \
    adduser user sudo

# Install Oh My Zsh for user 'user'
USER user
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# Switch back to root
USER root

# Set the working directory to user's home directory
WORKDIR /home/user

# Set the entrypoint to Zsh
ENTRYPOINT ["/bin/zsh"]

