node {
    environment {
    dockerhub=credentials('docker-hub-credentials')
  }
      stage "Container Prep"
    // do the thing in the container
      docker.image('egupoff/alpine-maven-agent:latest').inside {
        // get the codez
        stage 'Checkout'
        git url: 'https://github.com/egupov/boxfuse.git'
        stage 'Build'
        // Do the build
        sh "mvn clean install"
        sh 'cp /root/.m2/repository/com/boxfuse/samples/hello/1.0/hello-1.0.war /usr/src/app'
        sh 'docker image build -t myproject-app /usr/src/app && docker tag myproject-app:latest egupoff/myproject-app:latest'
        stage 'Push'
        // Do the push
        sh 'echo $docker-hub-credentials_PSW | docker login -u $docker-hub-credentials_USR --password-stdin'
        sh 'docker push egupoff/myproject-app:latest'
        sh "docker rmi egupoff/myproject-app:latest"
    }
}
