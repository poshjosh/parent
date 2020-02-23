#!/usr/bin/env groovy
/**
 * https://github.com/poshjosh/parent
 * @see https://hub.docker.com/_/maven
 *
 * Only double quoted strings support the dollar-sign ($) based string interpolation.
 *
 * Do not use --rm in args as the container will be removed by Jenkins after being 
 * run, and jenkins will complain about not being able to remove the container if
 * already removed due to --rm option in args.
 */
pipeline {
    environment {
        IMAGE_NAME = 'com.looseboxes/parent:latest'
        dockerImage = ''
    }
    agent { 
        dockerfile {
            filename 'Dockerfile'
            args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/usr/src/app -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/app/target" -w /usr/src/app' 
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clone Git') {
            steps {
                git '/home/Documents/NetBeansProjects/parent'
            }
        }
        stage('Clean') {
            steps {
                sh 'mvn -B clean'
            }
        }
        stage('Build Image') {
            steps{
                script {
                   dockerImage = docker.build -t ${IMAGE_NAME} -f Dockerfile
                }
            }
        }
        stage('Install') {
            steps {
                sh '''
                    "mvn install:install help:evaluate -Dexpression=project.name"
                '''    
            }
        }
        stage('Deploy Image') {
            environment {
                DOCKERHUB_CREDS = credentials('dockerhub-creds')
            }
            steps{
                script {
                    docker.withRegistry( '', DOCKERHUB_CREDS ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Clean Up') {
            steps {
                sh '''
                    "if rm -rf target; then echo 'target dir removed'; else echo 'failed to remove target dir'; fi"
                    "docker rmi ${IMAGE_NAME}"    
                '''
            } 
        }
    }
}
