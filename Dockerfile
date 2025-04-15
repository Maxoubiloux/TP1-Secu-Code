FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    wget \
    apt-transport-https \
    gnupg \
    lsb-release \
    ca-certificates

RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/trivy-archive-keyring.gpg] https://aquasecurity.github.io/trivy-repo/deb buster main" > /etc/apt/sources.list.d/trivy.list

RUN apt-get update && apt-get install -y trivy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/share/maven/bin:${PATH}"

USER jenkins