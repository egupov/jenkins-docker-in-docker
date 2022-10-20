###
docker image build -t maven-agent . && docker tag maven-agent:latest egupoff/alpine-maven-agent:latest && docker push egupoff/alpine-maven-agent:latest
#&& docker run -it -v "/var/run/docker.sock:/var/run/docker.sock:rw" maven-agent /bin/sh