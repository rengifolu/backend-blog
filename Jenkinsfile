node {
  try{
    stage 'checkout project'
    checkout scm

    stage 'check env'
    sh "mvn -v"
    sh "java -version"

    stage 'test'
    sh "mvn test"

    stage 'package'
    sh "mvn package"

    stage 'report'
    step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])

    stage 'Artifact'
    step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])

    stage 'deploy on kubernetes'
    sh "kubectl version"
    stage('Apply Kubernetes files') {
        withKubeConfig([credentialsId: 'diego', serverUrl: 'https://192.168.2.127:6443']) {
          sh 'kubectl apply -f deployment.yml'
        }
    }

  }catch(e){
    throw e;
  }
}