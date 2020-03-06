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
def IMAGE_NAME = 'poshjosh/parent:latest'
pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile'
            registryCredentialsId 'dockerhub-creds'
            args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/usr/src/app -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/app/target" -w /usr/src/app' 
            additionalBuildArgs "-t ${IMAGE_NAME}"
        }
    }
    environment {
        IMG = 'poshjosh/parent:latest'
        PATH = "C:/Program Files/Docker/Docker/resources/bin:$PATH"
        registryCredentialsId 'dockerhub-creds'
        dockerImage = ''
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
        stage('Build Image') {
            steps{
                script {
                    dockerImage = docker.build IMG
                }
            }
        }
        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredentialsId ) {
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
