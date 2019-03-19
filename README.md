# Lab 4: PKI-1: HTTPS and Reverse Proxy
## Point your domain name to your VM instance    
In order to access your server using your domain name, you'll need to 
create DNS record(s) in your web hosting panel. Usually, this is under the
"DNS Settings" or something. Since I used Google Domains, this is what I did.    
<img src="https://github.com/dkindt/it366/blob/master/images/kibana_dns.png"/>

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

#### Secure Kibana with a login portal   
```
$ echo "it366TA:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users
```   
Create a password when prompted.   

#### Create an Nginx config for your domain   
```
$ sudo vim /etc/nginx/sites-available/[your-domain].com
server {
	
  # replace 'kibana.dkindt.com' with your FQDN.
	server_name kibana.dkindt.com;
	
  # links the username and password created earlier.
	auth_basic "Restricted Access";
	auth_basic_user_file /etc/nginx/htpasswd.users;

	location / {
		proxy_pass http://localhost:5601;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection 'upgrade';
		proxy_set_header Host $host;
		proxy_cache_bypass $http_upgrade;
	}
}
$ sudo ln -s /etc/nginx/sites-available/[your-domain].com /etc/nginx/sites-enabled/[your-domain].com
```   
__Check your config file for any syntax errors and apply changes__   
```
$ sudo nginx -t
$ sudo systemctl restart nginx
```   
Verify by going to navigating to your URL in the browser.   
#### Setting up SSL using Certbot    
Run the following commands and answer any questions when prompted. Make sure
to setup auto-forwarding for http requests, so that they will redirect to using
your https domain. 
Note: We are running certbot with the --nginx flag to use the nginx plugin. 
The --dry-run tests the auto-renewal process of certbot.    
```
$ sudo certbot --nginx -d [your-domain].com
$ sudo certbot renew --dry-run
```
## Resources
- https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx.html
- https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04
- https://support.google.com/domains/answer/3290309?hl=en

## Screenshots

<img src="https://github.com/dkindt/it366/blob/master/images/kibana_dkindt.png"/>
<img src="https://github.com/dkindt/it366/blob/master/images/kibana_ssl.png"/>

