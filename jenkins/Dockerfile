# 指定基础镜像
FROM jenkins/jenkins:2.421-jdk17

# 禁用 Jenkins 安装向导
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# 使用 root 用户安装依赖
USER root

# 安装 Docker CLI
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
 && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
 && apt-get update \
 && apt-get install -y docker-ce-cli

# 安装 Maven
RUN apt-get update && apt-get install -y maven

# 安装 Node.js (版本 18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs

# 安装 kubectl
RUN curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
RUN echo "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update & apt-get install -y  kubectl

# 清理缓存以减小镜像体积
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装 Jenkins 插件
# 注意：最好指定插件的版本号以确保构建的一致性，这里使用latest仅作为示例
RUN jenkins-plugin-cli --plugins \
    git \
    maven-plugin \
    kubernetes \
    kubernetes-cli \
    docker-plugin \
    docker-workflow \
    workflow-aggregator \
    pipeline-stage-view \
    htmlpublisher

# 切换回 Jenkins 用户
USER jenkins

# 暴露 Jenkins 端口
EXPOSE 8080 50000


