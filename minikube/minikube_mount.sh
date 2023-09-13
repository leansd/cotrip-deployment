# 如果需要在minikube上使用host形式的PV，请注意这个是mount在minikube虚拟机内部的。
# 为了能够把minikube虚拟机上的目录和宿主机目录联系起来，请使用minikube mount
# 下面是一个示例：
# minikube mount /Users/gangz/data:/home/docker/data