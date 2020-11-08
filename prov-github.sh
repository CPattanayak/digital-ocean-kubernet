#!/bin/bash
#
# Script to connect to prod kubernet
#
#cd provission_cluster
export token=''
export reponame='my-repo'
export repodescription='my-repo'
cd provision_github
terraform init
terraform apply -auto-approve -var do_token=$token -var reponame=$reponame -var description=$repodescription

curl https://start.spring.io/starter.tgz -d groupId=com.starter.project -d artifactId=$reponame name=DemoApp -d javaVersion=1.8 bootVersion=2.1.0.RELEASE -d dependencies=web,actuator -d language=java -d type=maven-project -d baseDir=$reponame | tar -xzvf -

cd $reponame
echo $reponame >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/CPattanayak/$reponame.git
git push -u origin main