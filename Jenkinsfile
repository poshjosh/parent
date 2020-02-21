/**
 * https://github.com/poshjosh/parent
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '--name parent -v /root/.m2:/root/.m2' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
        }
    }
    stages {
        stage('Install') {
            steps {
                sh 'mvn install:install help:evaluate -Dexpression=project.name'
            }
        }
        stage('Finish') {
            steps {
                sh 'echo x x x x x x x COMPLETED x x x x x x x'
            }
        }
    }
}
