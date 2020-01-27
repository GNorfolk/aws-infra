# AWS-Infra

## Local Setup

### Prerequiisite
- Create repo in Github
- git pull repo
- Somehow get it so you can push changes to Github

### MacOS
- brew cask install homebrew/cask-versions/adoptopenjdk8
- brew install jenkins-lts
- brew services start jenkins-lts
- brew cask install ngrok
- ngrok http 8080

### Windows
- Install AWS CLI:
- Source: https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html
- Download Python 64-bit installer and setup custom install to add Python3 to path and install pip3
- type `python --version` and `pip3 --version` to test install (may require cmd restart)
- type `pip3 install awscli` and then test install using `aws --version` or `aws s3 ls`
- type `pip3 install --user --upgrade awscli`
- type `aws configure` to setup .aws folder
- Download and install Jenkins
- Source: https://www.theserverside.com/tutorial/Use-the-Jenkins-OAuth-plug-in-to-securely-pull-from-GitHub
- When it asks for a URL ie http://localhost:8080 you need to use ngrok.io:
- Sources:
- https://dzone.com/articles/adding-a-github-webhook-in-your-jenkins-pipeline
- https://ngrok.com/download => run ngrok http 8080 in cmd
- Instead of http://localhost:8080 use https://228b9f82.ngrok.io to forward to your localhost

### Common
- Complete  installation of jenkins
- Install Jenkins OAuth plugin via Manage Jenkins - Manage Plugins
- Register new OAuth app on Github using https://github.com/settings/applications/new
- Application name is JenkinsIntegration
- Homepage URL is https://228b9f82.ngrok.io
- Authorisation callback URL is https://228b9f82.ngrok.io/securityRealm/finishLogin
- Copy ClientID and ClientSecret for next steps
- On Jenkins goto Manage Jenkins => Configure Global Security:
- Set Security Realm to Github Auth Plugin and set values:
- GitHub Web URI: https://github.com/GNorfolk/Curriculum-Vitae
- Github API URI: https://api.github.com
- ClientID: <ClientID>
- Client Secret: <ClientSecret>
- Authorisation: Anyone can do anything
- Create Jenkins pipeline
- Set Pipeline to pull from your repo via https
- Add new credentials using Jenkins Username and Password setup in Jenkins setup
- Kick off pipeline with basic template to test.

### AWS setup
- Add roles and stuff to authenticate with AWS.
- Created new user called "Admin"
- Ran `aws configure` and added AccessID and SecretKey from User creation
- Downloaded terraform v0.12 and added to PATH env
- Create bucket called norfolkgaming-tfstate
- Create IAM role for infra deployment
