docker run --user=root --volume=/run/host-services/docker.proxy.sock:/var/run/docker.sock -p 9099:8080  -d registry.cn-hangzhou.aliyuncs.com/leansd/jenkins 
