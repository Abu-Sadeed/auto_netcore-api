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
                        sh "dotnet publish -c release -o /var/lib/jenkins/workspace/auto_netcoreApi_master"
                        sh "rsync -a /var/lib/jenkins/workspace/auto_netcoreApi_master sadeed@127.0.0.1:/home/sadeed/workspace/pracs/dotnetJenkins/autoNetcore/master"
                        sh "echo  master publish complete"
                    } 
                    if(env.BRANCH_NAME == 'dev') {
                        sh "dotnet publish -c release -o /var/lib/jenkins/workspace/auto_netcoreApi_dev"
                        sh "rsync -a /var/lib/jenkins/workspace/auto_netcoreApi_dev sadeed@127.0.0.1:/home/sadeed/workspace/pracs/dotnetJenkins/autoNetcore/dev"
                        sh "echo master Deploy complete"
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
                        sh "ssh sadeed@localhost 'sudo /home/sadeed/workspace/pracs/autoShell/auto_netcore-api/svcscripts/svcOne.sh jsonTwo.json'"
                        //sh "sudo systemctl restart netcore-api_publish.service"
                    } 
                    if (env.BRANCH_NAME == 'dev') {
                        sh "ssh sadeed@localhost 'sudo /home/sadeed/workspace/pracs/autoShell/auto_netcore-api/svcscripts/svcOne.sh jsonOne.json'"
                        //sh "sudo systemctl restart netcore-api.service"
                    }
                }
            }
        }
    }
}