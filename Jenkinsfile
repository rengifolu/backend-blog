pipeline {
    agent any
    environment {
        registry = "rengifolu/backend-blog"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }

    // tools {nodejs "NodeJS"}
     tools {
        maven 'M3'
      }
    stages {

        stage('Git') {
            steps {
                checkout scm
            }
        }

        stage('check env') {
          steps{
           sh "mvn -v"
           sh "java -version"
          }
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
            steps{
               step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
            }
        }


        stage('Building our image') {

            steps {
                     sh "ls -l target"
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"

                }
                sh "ls -l"
            }

        }

        stage('Deploy our image') {

            steps {

                script {
                     sh "ls -l"
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


        /*stage('Deploy App on kubernetes') {
            steps {
                script {

                    def yamlText = readFile "deployment.yml"
                    yamlText = yamlText.replaceAll("BUILD_NUMBER", "${BUILD_NUMBER}")
                    echo yamlText

                    writeFile file: "deployment.yml", text: yamlText
                    kubernetesDeploy(configs: "deployment.yml", kubeconfigId: "mykubeconfig")

                    //sh 'kubectl apply -f deployment.yaml'

                }
            }
        }*/
    }
}

// void whateverFunction() {
//     sh 'ls -l /'
// }
