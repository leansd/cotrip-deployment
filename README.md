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

提示1： 我们使用leansd做为kubernetes的namespace

    kubectl create ns leansd

提示2： yaml文件使用Kustomize做模板，节省重复的部分。 https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/

    kubectl apply -k 

base目录是最基础，以调试模式启动的环境

    https://www.keycloak.org/server/containers#_trying_keycloak_in_development_mode

再次强调，不能用于生产或公网访问环境（以防恶意攻击）。 

kubectl port-forward -n leansd pod/keycloak-84574b799d-hdgh8 8080

能够使用admin/admin登录keycloak，并且登录以后能够在左侧上方下来框中切换到leansd（默认选择的是admin）