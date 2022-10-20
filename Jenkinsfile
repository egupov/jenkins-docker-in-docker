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
        sh 'docker run --rm -d --group-add $(stat -c '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock -P egupoff/alpine-maven-agent'
        git 'https://github.com/egupov/boxfuse.git'
        sh 'mvn clean package'
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