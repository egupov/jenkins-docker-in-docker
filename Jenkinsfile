node {
    environment {
    registry = "egupoff/myproject-app"
    registryCredential = ‘docker-hub-credentials’
}
      stage "Container Prep"
    // do the thing in the container
      docker.image('egupoff/alpine-maven-agent:latest').inside("--volume=/var/run/docker.sock:/var/run/docker.sock") {
        // get the codez
        stage 'Checkout'
        git url: 'https://github.com/egupov/boxfuse.git'
        stage 'Build'
        // Do the build
        sh "mvn clean install"
        sh 'cp /root/.m2/repository/com/boxfuse/samples/hello/1.0/hello-1.0.war /usr/src/app'
        sh 'tree /usr/src'
        sh "echo COPY ./*.war /usr/local/tomcat/webapps >> Dockerfile"
        sh 'docker build -t myproject-app -f /usr/src/app/Dockerfile .'
        sh 'docker tag myproject-app:latest egupoff/myproject-app:latest'
      stage 'Push'
    // Do the push
      withDockerRegistry([ credentialsId: "docker-hub-credentials" ]) {
      docker.image('egupoff/myproject-app:latest').push(commitID(latest))}
      sh "docker rmi egupoff/myproject-app:latest"
    }
}
