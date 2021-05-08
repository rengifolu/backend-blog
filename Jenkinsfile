pipeline {
    agent any
    environment {
        registry = "rengifolu/backend-blog"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }

    // tools {nodejs "NodeJS"}
    stages {

        stage('Git') {
            steps {
                checkout scm
            }
        }

        stage('check env') {
           sh "mvn -v"
           sh "java -version"
        }

        stage('test') {
        steps {
        sh "mvn test"
          }
        }

        stage('package') {
           steps{
           sh "mvn package"
           }
        }

        stage('report') {
            steps{
               step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
            }
        }

        stage('Artifact') {
           step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
        }


        stage('Building our image') {

            steps {

                script {

                    dockerImage = docker.build registry + ":$BUILD_NUMBER"

                }

            }

        }

        stage('Deploy our image') {

            steps {

                script {

                    docker.withRegistry( '', registryCredential ) {

                        dockerImage.push()

                    }

                }

            }

        }

        stage('Cleaning up') {

            steps {

                sh "docker rmi $registry:$BUILD_NUMBER"

            }

        }


        stage('Deploy App') {
            steps {
                script {

                  sh "kubectl version"
                  kubernetesDeploy(configs: "deployment.yml", kubeconfigId: "mykubeconfig")

                }
            }
        }
    }
}

// void whateverFunction() {
//     sh 'ls -l /'
// }