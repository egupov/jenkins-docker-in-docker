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
        docker.build('egupoff/alpine-maven-agent:latest') {
        sh 'git clone https://github.com/egupov/boxfuse.git'
      }
    }
    }
    stage('Build jar') {
      steps {
        sh 'cd boxfuse && mvn package'
      }
    }

    stage('Make docker image') {
      steps {
        sh 'docker image build -t myproject-app . && docker tag myproject-app:latest egupoff/myproject-app:latest'
        sh 'echo $docker-hub-credentials_PSW | docker login -u $docker-hub-credentials_USR --password-stdin'
      }
    }

    stage('Push image') {
      steps {
          sh 'docker push egupoff/myproject-app:latest'
        }
      }

      stage('Cleaning up') {
        steps {
          sh "docker rmi egupoff/myproject-app:latest"
        }
      }
    }
  }