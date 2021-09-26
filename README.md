# backend-blog


docker run -p 5050:80 -e 'PGADMIN_DEFAULT_EMAIL=rengifolu@gmail.com' -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' -d dpage/pgadmin4

# backend-blog
docker run --name backend-blog -p 8085:8085 rengifolu/backend-blog
