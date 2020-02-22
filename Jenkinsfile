/**
 * https://github.com/poshjosh/parent
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '--name looseboxes-parent -v /root/.m2:/root/.m2' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
        }
    }
    stages {
        stage('Clean') {
            steps {
                sh 'mvn clean:clean'
            }
        }
        stage('Install') {
            steps {
                sh 'mvn install:install help:evaluate -Dexpression=project.name'
            }
        }
    }
}
