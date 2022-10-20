pipeline {
  agent all {

    docker {
      image 'egupoff/alpine-maven-agent:latest'
    }
  }

  stages {

    stage('Copy source with configs') {
      steps {
        git(url: 'https://github.com/egupov/boxfuse.git', branch: 'master', poll: true, credentialsId: 'git')
      }
    }

    stage('Build jar') {
      steps {
        sh 'cd boxfuse && mvn package'
      }
    }

    stage('Make docker image') {
      steps {
        sh 'cd /root'
        git(url: 'https://github.com/egupov/jenkins-docker-in-docker.git', branch: 'master', poll: true, credentialsId: 'git') 
        sh 'cp /usr/src/app/boxfuse/target/hello-1.0.war /root/jenkins-docker-in-docker/' 
        sh 'docker image build -t myproject-app . && docker tag myproject-app:latest egupoff/myproject-app:latest'
      }
    }

    stage('Push image') {
      steps {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
          app.push("egupoff/myproject-app:latest")
          app.push("latest")
          sh 'docker rmi egupoff/myproject-app:latest'
      }
    }
  }
}