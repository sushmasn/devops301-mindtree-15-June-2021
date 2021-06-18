node('master') {
    
  // Get Artifactory Server Instance Details
  def server = Artifactory.server "01"
  def buildInfo = Artifactory.newBuildInfo()
  
  // Project Variables
  def project_path = "03-App-Code/petclinic-code"
	
    
    stage('Git-CheckOut') {
      git branch: 'main', url: 'https://github.com/amitvashisttech/devops301-mindtree-15-June-2021.git'
    }  
    
  dir(project_path) {
    
    stage('Maven-Clean') {
      sh ' mvn clean'
    }
    
    stage('Maven-Compile') {
      sh ' mvn compile'
    }
    
    stage('Maven-Test') {
      sh ' mvn test'
    }
    
    stage('Maven-Package') {
      sh ' mvn package'
    }  
	
    	
    stage('SonarQube') {
      withSonarQubeEnv('Sonar') {
      sh 'mvn sonar:sonar'
     }
   }  

	stage('Build Management') {
		def uploadSpec = """{ 
			"files": [
			{
			"pattern": "**/*.war",
			"target": "petclinic-war"
			}
		]

	}"""
	
	server.upload spec: uploadSpec
   }
   
   
   
   

	stage('Publish Build Info'){
		server.publishBuildInfo buildInfo
	}

    
    stage('Archive Artifact') {
      archiveArtifacts artifacts: 'target/*.war', followSymlinks: false
    }  


   stage('Download Package') {
   def downloadSpec = """{ 
     "files": [
       {
        "pattern": "petclinic-war/*.war",
         "target": "ansible-code/roles/petclinic/files/"
       }
      ]

   }"""
      server.download spec: downloadSpec
   }

  stage('Getting Ready For Ansible Deployment'){
     sh "echo \'<h1>JENKINS TASK BUILD ID: ${env.BUILD_DISPLAY_NAME}</h1>\' > ansible-code/roles/petclinic/files/index.html"
  }

  

    
  stage('Ansible Deployment'){
     sh "cd ansible-code;ansible-playbook petclinic.yaml"
  }
  
    
  }
    
    
    
}
