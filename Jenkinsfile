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
                sh "gradle clean-custom"
                sh "gradle test-custom"
            }
        }
        stage('build') {
            steps {
                 script {
                    version = sh(returnStdout: true, script: "grep 'version' build.gradle | cut -d ' ' -f2").trim()
                    package_name = sh(returnStdout: true, script: "grep 'archivesBaseName' build.gradle | cut -d ' ' -f3").trim()
                 }
                
                sh "gradle build-custom"
                sh "docker build -t $package_name:v$version-b${BUILD_NUMBER} ."
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    sh "tar -czvf build/libs/${ARTEFACT_NAME} build/libs/$package_name-$version'.'jar"
                }
            }
        }
        stage('deploy') {
            steps {
                 script {
                    output = sh(returnStdout: true, script: "docker run -i $package_name:v$version-b${BUILD_NUMBER}")
                    sh "echo $output"
                 }
                writeFile file: 'output.log', text: output
                sh "echo 'Output saved to output.log'"
            }
        }
    }
}