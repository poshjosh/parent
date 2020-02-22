/**
 * https://github.com/poshjosh/parent
 * @see https://hub.docker.com/_/maven
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '--rm --name looseboxes-parent -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/usr/src/app -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/app/target" -w /usr/src/app' 
            additionalBuildArgs '-t com.looseboxes/parent:latest'
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
                sh "if rm -rf target; then echo 'target dir removed'; else echo 'failed to remove target dir'; fi"
            } 
        }
    }
}
