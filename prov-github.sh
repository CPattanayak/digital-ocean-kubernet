#!/bin/bash
#
# Script to connect to prod kubernet
#
#cd provission_cluster
export token=''
export reponame='my-repo'
export repodescription='my-repo'
export springdependancies='web,actuator'
export starterAppName='MyRepoApp'
export groupid='com.starter.project'
export githubuser='CPattanayak'

cd provision_github
terraform init
terraform apply -auto-approve -var do_token=$token -var reponame=$reponame -var description=$repodescription -var githubuser=$githubuser

curl https://start.spring.io/starter.tgz -d groupId=$groupid -d artifactId=$reponame name=$starterAppName -d javaVersion=1.8 bootVersion=2.1.0.RELEASE -d dependencies=$springdependancies -d language=java -d type=maven-project -d baseDir=$reponame | tar -xzvf -

cd $reponame
echo $repodescription >> README.md
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/$githubuser/$reponame.git
git push -u origin main
cd ..
rm -rf $reponame