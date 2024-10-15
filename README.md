# Assignment 2:
# G01448553 - Akshitha Kolanupaka

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


2. Installing rancher on AWS
