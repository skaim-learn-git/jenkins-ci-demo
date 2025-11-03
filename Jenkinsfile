pipeline {
    agent any
    environment {
        AWS_REGION = 'ap-south-1'
        REPO_URI = '<your-account-id>.dkr.ecr.ap-south-1.amazonaws.com/jenkins-demo'
        IMAGE_TAG = "build-${env.BUILD_ID}"
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-username>/jenkins-demo.git'
            }
        }
        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPO_URI
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $REPO_URI:$IMAGE_TAG .
                '''
            }
        }
        stage('Push Image to ECR') {
            steps {
                sh '''
                docker push $REPO_URI:$IMAGE_TAG
                '''
            }
        }
    }
    post {
        success {
            echo "✅ Image successfully pushed to $REPO_URI:$IMAGE_TAG"
        }
        failure {
            echo "❌ Build failed. Check Jenkins logs."
        }
    }
}
