server {
	
	server_name dkindt.com www.dkindt.com;
	
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
    ssl_certificate /etc/letsencrypt/live/dkindt.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/dkindt.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.dkindt.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = dkindt.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


	listen 80;
	
	server_name dkindt.com www.dkindt.com;
    return 404; # managed by Certbot




}