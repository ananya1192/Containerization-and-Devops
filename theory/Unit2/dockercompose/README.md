# Docker Compose vs Docker Run

1. Running Nginx with Docker Run
```bash
docker run \
  --name my-nginx \
  -p 8080:80 \
  -v ./html:/usr/share/nginx/html \
  -e NGINX_HOST=localhost \
  --restart unless-stopped \
  -d \
  nginx:alpine
```
![](./images/img1.png)

2. Same setup with Docker Compose

- Create [docker-compose.yml](./docker-compose.yml) : 
```bash
version: '3.8'
services:
  nginx:
    image: nginx:alpine          
    container_name: my-nginx     
    ports:
      - "8080:80"              
    volumes:
      - ./html:/usr/share/nginx/html  
    environment:
      - NGINX_HOST=localhost    
    restart: unless-stopped     
```

3. Create container using Docker Compose.
```bash
docker-compose up -d
```
![](./images/img2.png)

4. Down container using Docker Compose
```bash
docker-compose down
```
![](./images/img3.png)

5. List the docker-compose logs
```bash
docker-compose logs
```
![](./images/img4.png)

6. Check status in docker-compose
```bash
docker-compose ps
```
![](./images/img5.png)

---
### Conclusion

Docker Compose is essentially a YAML-based abstraction layer over multiple

1. Translates directly: Every Compose option has a corresponding
2. Simplifies complex setups: Instead of remembering multiple commands, you define everything in one file
3. Manages relationships: Handles dependencies between containers automatically
4. Provides consistency: Ensures the same configuration is used every time

- docker run = Imperative approach ("Do these steps")
- docker-compose = Declarative approach ("Here's what I want")

This makes Docker Compose especially valuable for development environments and multi-service applications where you
need to coordinate several containers working together.

