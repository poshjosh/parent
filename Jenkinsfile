#!/usr/bin/env groovy
/**
 * https://github.com/poshjosh/parent
 * @see https://hub.docker.com/_/maven
 */
pipeline {
    agent any
    environment {
        ARTIFACTID = readMavenPom().getArtifactId();
        VERSION = readMavenPom().getVersion()
        PROJECT_NAME = "${ARTIFACTID}:${VERSION}"
        IMAGE_REF = "poshjosh/${PROJECT_NAME}";
        IMAGE_NAME = IMAGE_REF.toLowerCase()
        VOLUME_BINDINGS = '-u 0 -v /home/.m2:/root/.m2 -v /usr/bin/docker:/usr/bin/docker'
    }
    options {
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '4'))
        skipStagesAfterUnstable()
        disableConcurrentBuilds()
    }
    triggers {
// @TODO use webhooks from GitHub
// Once in every 2 hours slot between 0900 and 1600 every Monday - Friday
        pollSCM('H H(8-16)/2 * * 1-5')
    }
    stages {
        stage('Build Image') {
            steps {
                echo " = = = = = = =  BUILDING IMAGE = = = = = = = "
//                script {
//                    def additionalBuildArgs = "--pull ${VOLUME_BINDINGS}"
//                    if (env.BRANCH_NAME == "master") {
//                        additionalBuildArgs = "--no-cache ${additionalBuildArgs}"
//                    }
//                    docker.build("${IMAGE_NAME}", "${additionalBuildArgs} .")
//                }
            }
        }
        stage('Clean & Install') {
            steps {
                echo " = = = = = = =  BUILDING IMAGE = = = = = = = "
//                script{
//                    docker.image("${IMAGE_NAME}").inside{
//                        sh 'mvn -B clean:clean install:install'
//                   }
//                }
            }
        }
        stage('Deploy Image') {
            when {
                branch 'master'
            }
            steps {
                echo " = = = = = = = DEPLOYING IMAGE = = = = = = = "
//                script {
//                    docker.withRegistry('', 'dockerhub-creds') { // Must have been specified in Jenkins
//                        sh "docker push ${IMAGE_NAME}"
//                    }
//                }
            }
        }
    }
    post {
        always {
            deleteDir() /* clean up workspace */
            sh "docker system prune -f --volumes"
        }
        failure {
            mail(
                to: 'posh.bc@gmail.com',
                subject: "$IMAGE_NAME - Build # $BUILD_NUMBER - FAILED!",
                body: "$IMAGE_NAME - Build # $BUILD_NUMBER - FAILED:\n\nCheck console output at ${env.BUILD_URL} to view the results."
            )
        }
    }
}
