pipeline {
  environment {
    dockerhub=credentials('docker-hub-credentials')
  }
  agent {

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
        sh 'echo $docker-hub-credentials_PSW | docker login -u $docker-hub-credentials_USR --password-stdin'
      }
    }

    stage('Push image') {
      steps {
          sh 'docker push egupoff/myproject-app:latest'
        }
      }
    }
  }