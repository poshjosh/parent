/**
 * https://github.com/poshjosh/parent
 * @see https://hub.docker.com/_/maven
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '--name looseboxes-bcutil -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/usr/src/app -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/app/target" -w /usr/src/app' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clean') {
            steps {
                sh 'mvn -B clean'
            }
        }
        stage('Install') {
            steps {
                sh 'mvn install:install help:evaluate -Dexpression=project.name'
            }
        }
        stage('Post Install') {
            steps {
                echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX CURRENT WORKING DIR is ${PWD}"
                sh 'rm -rf target'
            } 
        }
    }
}
