server {
	
	server_name kibana.dkindt.com;
	
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


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/kibana.dkindt.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/kibana.dkindt.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = kibana.dkindt.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


	
	server_name kibana.dkindt.com;
    listen 80;
    return 404; # managed by Certbot


}