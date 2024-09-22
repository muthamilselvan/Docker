FROM ubuntu 
			RUN apt update -y 
			RUN apt install git -y 
			RUN apt install maven -y 
			RUN apt install nginx -y 
			
				docker build -t doccontent/bs-img1 .	

  Docker Volume :::
	
		- Are used to maintain the persisant data 
		
		- docker volume list 
		
		- docker volume create tcs-vol 
		
		- docker volume inspect tcs-vol 
	
		- docker run -it --mount source=tcs-vol1,destination=/tcs-vol1 centos bash


      stage('Build Docker Image') {
            steps {
				sh 'docker version'
				sh "docker build -t loksaieta/loksai-eta-app:${BUILD_NUMBER} ."
				sh 'docker image list'
				sh "docker tag loksaieta/loksai-eta-app:${BUILD_NUMBER} loksaieta/loksai-eta-app:latest"
            }
        }

		stage('Login2DockerHub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		stage('Publish_to_Docker_Registry') {
			steps {
				sh "docker push loksaieta/loksai-eta-app:latest"
			}
