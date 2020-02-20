/**
 * github.com/poshjosh/parent
 */
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '-v /root/.m2:/root/.m2' 
            additionalBuildArgs '-t com.looseboxes/parent:1.0-SNAPSHOT'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clean') {
            steps {
                sh 'mvn -B -DskipTests clean' 
            }
        }
        stage('Install') {
            steps {
                sh 'mvn jar:jar install:install help:evaluate -Dexpression=project.name'
            }
        }
    }
}
