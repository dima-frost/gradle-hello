pipeline {
    agent any

    tools {
        gradle "gradle-8.6-milestone-1"
    }
     environment {
        ARTEFACT_NAME = "hello-${BUILD_NUMBER}.tar.gz"
    }

    stages {
        stage('test') {
            steps {
            
                sh "gradle test-custom"
            }
        }
        stage('build') {
            steps {
            
                sh "gradle build-custom"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    sh "tar -czvf build/libs/${ARTEFACT_NAME} build/libs/hello*.jar"
                }
            }
        }
        stage('deploy') {
            steps {
                sh "java -jar build/libs/hello*.jar | tee output.log"
            }
        }
    }
}