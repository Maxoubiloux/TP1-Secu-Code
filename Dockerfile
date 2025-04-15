FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        apt-transport-https \
        gnupg \
        lsb-release \
        ca-certificates && \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" > /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends trivy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins