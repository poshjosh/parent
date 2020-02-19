/**
 * github.com/poshjosh/parent
 * https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/
 * docker:build is a fabric8 command for building docker image
 */
pipeline {
    agent { 
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2' 
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "- - - - - - - Stage: INITIALIZING - - - - - - -"
                    echo "M2_HOME = %M2_HOME%"
                    echo "JAVA_HOME = %JAVA_HOME%"
                    echo "- - - - - - - DONE INITIALIZING - - - - - - -"
                '''
            }
        }
        stage('Clean and Build') {
            steps {
                sh 'mvn -B -DskipTests clean install' 
            }
        }
        stage('Install') {
            steps {
                sh './jenkins_script_install.sh'
            }
        }
    }
}
