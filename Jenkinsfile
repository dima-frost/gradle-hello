pipeline {
    agent any

    tools {
        maven "maven-3.9.6"
    }
     environment {
        ARTEFACT_NAME=hello-${BUILD_NUMBER}.tar.gz
    }

    stages {
        stage('Build') {
            steps {
            
                sh "mvn clean package"
                
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
    }
}