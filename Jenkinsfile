pipeline {
    agent any
    stages {
        stage('Restore') {
            steps {
                sh "dotnet restore"
                sh "echo Restore Complete"
            }
        }
        stage('Build') {
            steps {
                sh "dotnet build"
                sh "echo Restore Complete"
            }
        }
        stage('Test') {
            steps {
                sh "dotnet test "
                sh "echo Test completed"
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        sh "dotnet publish -c release -o /var/lib/jenkins/workspace/netcoreApi/output/publish"
                        sh "rsync -a /var/lib/jenkins/workspace/netcoreApi/output/publish sadeed@127.0.0.1:/home/sadeed/workspace/pracs/dotnetJenkins/netcore/publish"
                        sh "echo publish complete"
                    } 
                    if(env.BRANCH_NAME == 'dev') {
                        sh "dotnet publish -c release -o /var/lib/jenkins/workspace/netcoreApi/output/dev"
                        sh "rsync -a /var/lib/jenkins/workspace/netcoreApi/output/dev sadeed@127.0.0.1:/home/sadeed/workspace/pracs/dotnetJenkins/netcore/dev"
                        sh "echo Deploy complete"
                    }
                }
            }
        }
        stage('Turn power') {
            steps {
                sh "ssh sadeed@localhost"
                sh "echo transfer Complete"
            }
        }
        stage('Restart') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        //sh "echo restart service"
                        //sh "sudo systemctl restart netcore-api_publish.service"
                    } 
                    if (env.BRANCH_NAME == 'dev') {
                        sh "echo restart dev service"
                        sh "sudo systemctl restart netcore-api.service"
                    }
                }
            }
        }
    }
}