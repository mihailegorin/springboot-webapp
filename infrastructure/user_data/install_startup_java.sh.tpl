#! /bin/bash
yum -y update
yum -y install java
aws s3 cp s3://"${artifact_bucket}"/artifacts/"${application_version}" ./ --recursive
sudo java -jar ./*.jar
