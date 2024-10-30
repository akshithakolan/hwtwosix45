# Assignment 2:
# G01448553 - Akshitha Kolanupaka

Team: Akshitha Kolanupaka, Mourya Reddy, Ram Puttagunta
AWS homepage link:
https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances:


Kubernetes:
 https://54.227.136.242/k8s/clusters/c-m-bfxjrhmz/api/v1/namespaces/default/services/http:deployy:8080/proxy/surhw2/

The following are the commands that we used for this project:

1. Creating a Docker image and pushing it to DockerHub
To build the Docker image, use the following command for apache server:
```
docker build -t survey .
```
```
(base) akshithakolanupaka@Akshithas-MacBook-Air-2 hwtwo % docker build -t survey .
[+] Building 0.6s (8/8) FINISHED                                   docker:desktop-linux
 => [internal] load build definition from Dockerfile                               0.0s
 => => transferring dockerfile: 200B                                               0.0s
 => [internal] load metadata for docker.io/library/httpd:latest                    0.4s
 => [internal] load .dockerignore                                                  0.0s
 => => transferring context: 2B                                                    0.0s
 => [internal] load build context                                                  0.0s
 => => transferring context: 5.62kB                                                0.0s
 => CACHED [1/3] FROM docker.io/library/httpd:latest@sha256:7204bce27072f97f24433  0.0s
 => => resolve docker.io/library/httpd:latest@sha256:7204bce27072f97f244337ebe93c  0.0s
 => [2/3] COPY ./survey.html /usr/local/apache2/htdocs/                            0.0s
 => [3/3] RUN chmod 777 /usr/local/apache2/htdocs/survey.html                      0.1s
 => exporting to image                                                             0.1s
 => => exporting layers                                                            0.0s
 => => exporting manifest sha256:d66ac84d329c623d2a067f6b9e54c1f83460e9a020fcdb4c  0.0s
 => => exporting config sha256:8695a029f91a7ac9df74d642840973c4472c023bec92672ab6  0.0s
 => => exporting attestation manifest sha256:30b519573418451e32fdcafdb9807f244245  0.0s
 => => exporting manifest list sha256:d4bb1635b7cf11bbb1e08c722eb119a3f6300d77d97  0.0s
 => => naming to docker.io/library/survey:latest                                   0.0s
 => => unpacking to docker.io/library/survey:latest                                0.0s

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview
    ```
To check if the image is bulit and the link works:
http://localhost/survey.html
```

Then use this command to login to docker and enter your password
```
docker login -u akolanup@gmu.edu
```


```
(base) akshithakolanupaka@Akshithas-MacBook-Air-2 hwtwo % docker login -u akolanup@gmu.edu
Password: 
Login Succeeded
```
On Docker hub :
to name the tag:
```
docker tag ac31c03b6755 docker.io/akolanup/survey:latest
```
To push the image to the repository created:
```
docker push akolanup/survey:latest
docker buildx build --platform linux/amd64,linux/arm64 \
  -t akolanup/survey:latest --push .
```


2. Installing rancher on AWS
2 instances were created
go to your root folder
```
 ssh -i 645hw2.pem ubuntu@44.211.219.150
```
instal docker on both:
```
sudo apt-get update
```

```
ubuntu@ip-172-31-90-54:~$ sudo apt install docker.io
```

install rancher ec1
```
sudo docker run --privileged=true -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
```
The Container ID was retrieved with: 
```
sudo docker ps
```
```
sudo docker logs [Container ID] 2>&1 | grep "Bootstrap Password:"
```
EC1:
```
ubuntu@ip-172-31-90-54:~$ sudo docker ps 
CONTAINER ID   IMAGE             COMMAND           CREATED          STATUS          PORTS                                                                      NAMES
362c177ac54d   rancher/rancher   "entrypoint.sh"   28 seconds ago   Up 21 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp   elastic_ardinghelli
ubuntu@ip-172-31-90-54:~$ sudo docker logs 362c177ac54d  2>&1 | grep "Bootstrap Password:" TO RETRIEVE THE PASS
```
do this command for sur2 in terminal
```
 curl --insecure -fL https://34.238.80.0/system-agent-install.sh | sudo  sh -s - --server https://34.238.80.0 --label 'cattle.io/os=linux' --token sxjsnv859smln6kx2l8xr4whdh55kwzh7brg4xz587rj9kx949zrxt --ca-checksum 8b1fbb9766086755ef6fa51dfaee61d39ab23e6a007379f14ad8a09204da756a --etcd --controlplane --worker
```
Upon cluster activation, navigate to the cluster and access the "Deployments" tab
within the workload section on the left-hand side.
R. Click on "Create" and proceed to generate a new deployment object with 3
replicas, configured as nodeport. You'll need to specify the image from Docker
Hub for this deployment: akolanup/survey:latest
For the port service type, select NodePort.
Then give it a name and for the private container port, list 8080.
Leave the listening port blank as it will auto populate that with a port from the range 30000-32767.
Then hit create at the bottom.

3. Jenkins

Set Up kubectl on Jenkins Instance: 
Install kubectl: 
```
sudo apt install snapd
sudo snap install kubectl --classic
sudo su jenkins
```
Configure kubeconfig in Jenkins - Copy the Rancher kubeconfig and paste it into /home/Jenkins/.kube/config on the Jenkins EC2 instance.

%snap install kubectl –classic
```
ubuntu@ip-172-31-18-184:~$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
38b86b425cb34383a29ede0d874b0bba
ubuntu@ip-172-31-18-184:~$ mkdir /var/lib/jenkins/.kube
mkdir: cannot create directory ‘/var/lib/jenkins/.kube’: Permission denied
ubuntu@ip-172-31-18-184:~$ sudo mkdir /var/lib/jenkins/.kube
ubuntu@ip-172-31-18-184:~$ touch /var/lib/jenkins/.kube/config
touch: cannot touch '/var/lib/jenkins/.kube/config': Permission denied
ubuntu@ip-172-31-18-184:~$ sudo touch /var/lib/jenkins/.kube/config
ubuntu@ip-172-31-18-184:~$ sudo vim /var/lib/jenkins/.kube/config
ubuntu@ip-172-31-18-184:~$ sudo usermod -aG docker jenkins
ubuntu@ip-172-31-18-184:~$ sudo systemctl restart jenkins
```




