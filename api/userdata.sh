
 
export IPADR=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

yum -y remove java-1.7.0-openjdk 
 
curl -v -k --user navitas:d88adab4dcf53a23dee949724b46f029 "http://jenkins.steadystatecd.com//view/ansible/job/provision-api-app/buildWithParameters?token=t123456&IPADDR=${IPADR}&APPENV=dev"
