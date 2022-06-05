# Generate and Self-Sign an SSL Certificate

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt
```

More info https://gist.github.com/jessedearing/2351836

## Certbot

https://mindsers.blog/post/https-using-nginx-certbot-docker/
