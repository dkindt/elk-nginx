# Lab 4: PKI-1: HTTPS and Reverse Proxy

## Securing your website with SSL
#### Install Nginx
`sudo apt update`   
`sudo apt install nginx`

#### Configure the Firewall
```
$ sudo ufw app list
Available Applications:   
...
  Nginx Full
  Nginx HTTP
  Nginx HTTPS
...
$ sudo ufw allow 'Nginx Full'
```   
#### Verify the installation   
At this point, your web server should be up and running. To verify, type: 
```
$ sudo systemctl status nginx 
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2019-03-16 00:10:45 UTC; 3 days ago
     Docs: man:nginx(8)
  Process: 733 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
  Process: 678 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
 Main PID: 736 (nginx)
    Tasks: 2 (limit: 4915)
   CGroup: /system.slice/nginx.service
           ├─ 736 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
           └─1002 nginx: worker process

Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
```
Another way to verify is to navigate to your VM instance from the browser: http://[server.ip.address]   

#### Create a login portal for Kibana 

## Resources
- https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx.html
- https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04
- https://support.google.com/domains/answer/3290309?hl=en

## Screenshots

<img src="https://github.com/dkindt/it366/blob/master/images/kibana_dkindt.png"/>
<img src="https://github.com/dkindt/it366/blob/master/images/kibana_dns.png"/>
<img src="https://github.com/dkindt/it366/blob/master/images/kibana_ssl.png"/>

