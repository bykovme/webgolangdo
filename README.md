# WIP: prepare clean Ubuntu machine to work as golang app server
bash script, it is preparing golang webapplication on newly created digital ocean droplet

You can run the script directly from github using the command below

```
bash <(curl -s https://raw.githubusercontent.com/bykovme/webgolangdo/master/preparegolangapp.sh)
```

### What exactly script is doing
1. Installs and configures firewall (ufw)
2. Installs git
3. Installs mysql and secures it with mysql_install_db
4. Installs the latest version of GO (1.7.5), configures go environment (PATH, GOPATH)
5. Installs go application from public git repository, yours od my demo (development for private is in progress) with 'go get'
6. Configures go app to work as a service (add config into /etc/init.d), starts the service
7. Installs and configures nginx to work as proxy for go app

### TO DO
- support for private git repositories with ssh
- sample for mysql usage in web app
- generate ssh keys to be used with private git repositories
- generage self-signed ssl certificate for nginx to publish the app on 443 port
- import signed ssl certificate for nginx

The script is tested using digital ocean ubuntu droplet

Script is asking all requered information during execution but you can speed up or automate its running if you setup some variables in advance

$MYSQL_PASS - password for MySQL root user  
$USERNAME - linux user, go app will run with this newly created user  
$PASSWORD - password for linux user  
$SERVERNAME - if you have domain, put it here (otherwise IP address will be used)  
$PORT - port where your go app is running (8080 by default)  

**WARNING! The main idea is already implemented but the script is still work in progress, use it on your oww risk  **



