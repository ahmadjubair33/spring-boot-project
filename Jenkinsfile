pipeline
{
    agent {
        label 'master'
    }
    tools
    {
        maven 'maven'
        jdk 'jenkins-jdk'
    }
    options
    {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
    }
    stages
    {
        stage("Cleanup")
        {
            steps
            {
                sh 'mvn clean'
            }
        }
        
        stage("Test")
        {
            steps
            {
                sh 'mvn test'
            }
        }
        stage("Package")
        {
            steps
            {
                sh 'mvn package'
            }
        }
    }

     post
    {
         always{
            mail to: 'ahmadjubair878@gmail.com',
			subject: "Pipeline: ${currentBuild.fullDisplayName} is ${currentBuild.currentResult}",
			body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}"
        }
	    success{
            sh 'echo "--------------------------Deploying------------------------------"'
            sshPublisher(publishers: [sshPublisherDesc(configName: 'deploy', transfers: [sshTransfer(cleanRemote: true, excludes: '', execCommand: '''cd  deploy/target
java -jar  *jar & ''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'deploy', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
       
	    }
         
    }
}
