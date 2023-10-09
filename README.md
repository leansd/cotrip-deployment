# 如何安装cotrip

技能需求：会使用docker或podman安装运用

2 Kubernetes的使用

启动服务器端的基本顺序
- keycloak
- cotrip
- cotrip-nginx

至此你可以有api可用

    curl -x GET http://localhost:8080/api/v1/health


## 在Kubernetes环境中安装

### 马上看效果

提示1： 我们使用leansd做为kubernetes的namespace

    kubectl create ns leansd

提示2： yaml文件使用Kustomize做模板，节省重复的部分。[此为kubectl内置的能力，详情参网站手册](https://kustomize.io/)


提示3：再次强调，不能用于生产或公网访问环境（以防恶意攻击）。 

将deplyemnet应用到leansd空间中

    kubectl apply -k base    

等待启动完全。

key

## 检查启动正常

### Keycloak能够登录，并看到leansd的realm

1. 将pod端口转出来

    kubectl port-forward -n leansd services/keycloak 8089 

2. 浏览器打开 localhost:8089. 能够使用admin/admin登录keycloak

3. 登录以后能够在左侧上方的下拉框中切换到leansd（默认选择的是admin）

4. 关闭窗口； ctrl-c 关闭端口转发

### Cotrip能curl到live-api接口

1. Pod端口转出来

    kubectl port-forward -n leansd services/cotrip 8080

### 补充说明

base目录是最基础，以调试模式启动的环境

    https://www.keycloak.org/server/containers#_trying_keycloak_in_development_mode

base 原则，在最小的依赖需求情况下，能够启动，并且看到接口的数据，仅能够用于调试。
    