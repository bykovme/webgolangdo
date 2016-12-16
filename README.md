# WIP: prepare clean Ubuntu machine to work as golang app server
bash script, it is preparing golang webapplication on newly created digital ocean droplet

You can run the script directly from github using the command below

```
bash <(curl -s https://raw.githubusercontent.com/bykovme/webgolangdo/master/preparegolangapp.sh)
```

The scripts installs golang, nginx, mysql and does all the preparations required to run golang program as web application, including small demo app configured as a service

The script is tested using digital ocean ubuntu droplet

**WARNING! The script is still work in progress, do not use it until this warning message desappears**
