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
        stage('Install') {
            steps {
                sh 'mvn install help:evaluate -Dexpression=project.name'
            }
        }
    }
}
