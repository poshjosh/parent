/**
 * https://github.com/poshjosh/parent
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '-v /root/.m2:/root/.m2' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
        }
    }
    stages {
        stage('Finish') {
            steps {
                sh 'echo x x x x x x x COMPLETED x x x x x x x'
            }
        }
    }
}
