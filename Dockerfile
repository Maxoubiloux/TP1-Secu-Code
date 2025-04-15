FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    wget \
    apt-transport-https \
    gnupg \
    lsb-release \
    ca-certificates

RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" > /etc/apt/sources.list.d/trivy.list && \
    apt-get update && apt-get install -y trivy && \
    apt-get clean

USER jenkins