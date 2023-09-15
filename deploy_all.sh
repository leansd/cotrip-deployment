## 切换到正确的Context

## 部署需要的Secret

# source secret.sh
# create_tls.sh

# 部署keycloak
# 创建Keycloak的PV
kubectl apply -f keycloak/keycloak-pv-host.yaml
kubectl apply -f keycloak/keycloak-deployment-with-init.yaml

# 部署cotrip
kubectl apply -f cotrip/cotrip-deployment.yaml
kubectl apply -f cotrip/cotrip-service.yaml

# 部署auth
kubectl apply -f auth/auth-deployment.yaml

# 部署ingress
kubectl apply -f ingress/ingress-class-nginx.yaml
kubectl apply -f ingress/cotrip-ingress.yaml
