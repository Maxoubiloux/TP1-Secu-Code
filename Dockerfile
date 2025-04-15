FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    wget \
    apt-transport-https \
    gnupg \
    lsb-release \
    ca-certificates \
    maven && \
    wget -qO /usr/share/keyrings/trivy-archive-keyring.gpg https://aquasecurity.github.io/trivy-repo/deb/public.key && \
    echo "deb [signed-by=/usr/share/keyrings/trivy-archive-keyring.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" > /etc/apt/sources.list.d/trivy.list && \
    apt-get update && apt-get install -y trivy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins