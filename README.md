# Demo Environment
![N|Solid](https://mms.businesswire.com/media/20211027005980/en/920861/5/EndavaLogo.jpg) 


[![Build Status](http://kostadiv.asuscomm.com:8080/buildStatus/icon?job=Clone-GitHub-project)](http://192.168.1.50:8080/job/Clone-GitHub-project/)

The Demo environment is created on private cloud (Home Lab)

## Hardware
### Asustor AS5304T
- 8 GB RAM
- 5TB HDD (RAID 5)
- CPU Intel Celeron J4105 quad-core 1.5GHz

### Asus Router
- DDNS configuration / Publishing service
- Port forwarding
- External Firewall
- DHCP / IP reservation

## Environment 
Virtual machines are created via Virtual Box v6.1.32 (149290) & web admin interface phpVirtualBox v6.1-0
### Host servers

| Server | IP | Datacenter |
| ------ |-------| ------ |
| Jenkins | 192.168.1.50 | Mladost |
| Node1 | 192.168.1.51 | Pancharevo |
| Node2 | 192.168.1.52 | Druzhba |
| Node3 | 192.168.1.53 | Lozenets |

> The examples with data centers are portrayed in this example are fictitious. No identification with actual places.

### Servers & Software
All hosts using [Ubuntu Server](https://ubuntu.com/download/server) for OS and [Docker](https://www.docker.com/) for containers. 
Jenkings is installed direcly on OS and host Jenikns.
Unfortunatelly, [MiniKube](https://minikube.sigs.k8s.io/docs/) require more RAM and it's imposible install it with multiple running hosts.
| Name | Version| Comment |
| ------ |-------| ------ |
| Ubuntu Server |22.04 | OS for Host servers |
| Docker CE |20.10.17 |Build, deploy, run, update and manage containers |
| Jenkins | 2.332.3| Automation tool for CI/CD |
| PHP/Apache |8.0 |Web Server |
| mySQL |3.8 |Database Server |
| HAProxy | 2.3 |Loadbalancer|


## Installation
### Install Jenkins 
The version of Jenkins included with the default Ubuntu packages is often behind the latest available version from the project itself. To ensure you have the latest fixes and features, use the project-maintained packages to install Jenkins.
First, add the repository key to your system:

```sh
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
```

The gpg --dearmor command is used to convert the key into a format that apt recognizes.
Next, let’s append the Debian package repository address to the server’s sources.list:
```sh
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
The [signed-by=/usr/share/keyrings/jenkins.gpg] portion of the line ensures that apt will verify files in the repository using the GPG key that you just downloaded.
After both commands have been entered, run apt update so that apt will use the new repository.

```sh
sudo apt update
```
Finally, install Jenkins and its dependencies:
```sh
sudo apt install jenkins
```
To set up your installation, visit Jenkins on its default port, 8080, using your server domain name or IP address: http://your_server_ip_or_domain:8080
In the terminal window, use the cat command to display the inital password:

```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

To install Jenkins agent on the host for remote execution and management, use script jenkins-salve-requirement.sh
> Note: Create Jenkins credential authentication via [SSH keys](https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/ssh-credentials-management-with-jenkins) 

### Jenkins Plugins

Jenkins provides two methods for [installing plugins](https://www.jenkins.io/doc/book/managing/plugins/) on the controller:
- Using the "Plugin Manager" in the web UI.
- Using the Jenkins CLI install-plugin command.

We are using default recommended plugins, inclding additional:
- Node and Label parameter
- Git
- GitHub
- Active Choises
- Embeddable Build Status


### Folder structure content 
You can find 2 folders - first one is `docker_files` . It contains yml files and dependancies for docker compose of Web, mySQL and Load balancer containers.
The second folder `install_scripts` contains bash scripts for docker and docker-compose actions.
> Note: Configure your accounts as sudoers and assign proper permissions over Jenkins working directory 

## Automation - Provisoning, load balancing, flow
Ahh, yes about all detailed things ... let me explain them on our demo session :blush:
