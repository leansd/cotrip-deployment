kubectl create secret generic cotrip-kv-secret \
  --from-literal=APP_SECRET= () \
  --from-literal=APP_ID= () \
  --from-literal=KEYCLOAK_ADMIN_USERNAME=admin \
  --from-literal=KEYCLOAK_ADMIN_PASSWORD=admin

kubectl create secret generic keycloak-config \
    --from-file=keycloak-config.json=./().json

kubectl create secret docker-registry aliyun-registry-key \
  --docker-server=registry.cn-hangzhou.aliyuncs.com \
  --docker-username=() \
  --docker-password=() 

