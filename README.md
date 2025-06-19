### Deploying a multi-tier application stack in AWS using EC2 instances 

## Repository URL - https://github.com/Mexxy-lab/Aws-multitierstack.git

- Stack is written in Java language, has 5 different services running on 5 different instances 

- We would be using the below infrastructure 

	- EC2 instances 		    | VMs for 4 services - Tomcat, MySQL, RabbitMQ, and Memcache services. 
	- Security Groups 		    | Used to manage the inbound and outbound traffics for all VMs or EC2 instances. We would have 3 security groups.  
	- Elastic Load balancers 	| Would replace the Nginx service 
	- Autoscaling service		| Would act as automation service for scaling our VMs or EC2 instances. Needed for cost control 
	- S3 and EFS 			    | Used for storage 
	- Route 53 			        | For DNS service and domain management

## Project Flow: Manual Set up for better understanding of AWS services

1) Log into AWS console 
2) Create Key pairs used to log into EC2 
3) Create Security groups for Load Balancers, tomcat and backend services
4) Launch instances with user-data (Bash scripts)
5) Update IP addresses to name mapping in route 53 
6) Build Application locally from source code 
7) Upload to S3 bucket 
8) Download artifact to EC2 instance where you have tomcat running 
9) Set up the Elastic Loadbalancers with HTTPS cert from ACM
10) Map ELB endpoint to website name in IONS DNS
11) Verify the infra set up 
12) Build Autoscaling Group for Tomcat Instances.


