/**
 * github.com/poshjosh/parent
 * https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/
 * docker:build is a fabric8 command for building docker image
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /root/.m2:/root/.m2 -v "$HOME/.m2":/root/.m2' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
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
