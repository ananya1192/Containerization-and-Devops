### Project Assignment 1 Containerized Web Application with PostgreSQL using Docker Compose and
Macvlan/Ipvlan

Objective

Design, containerize, and deploy a web application using:

- PostgreSQL (mandatory database)
- Backend API using either Node.js + Express OR FastAPI
- Docker multi-stage builds
- Separate Dockerfiles (Backend + Database)
- Docker Compose for orchestration
- Macvlan or Ipvlan networking (mandatory)

---
Step 1. Initialize a node package
```bash
npm init -y
```
![](./images/img1.png)

Step 2. Install necessary packages
```bash
npm i express pg
```
![](./images/img2.png)

Step 3. Create [package.json](./package.json)

Step 4. Create [server.js](./backend/src/server.js)

Step 5. Create [Dockerfile](./backend/Dockerfile) for backend

Step 6. Create .dockerignore file and include the following :
```bash
node_modules
npm-debug.log
Dockerfile
.git
.gitignore
```
Step 7. Create [Dockerfile](./database/Dockerfile) for database
```bash
FROM postgres:15-alpine

COPY init.sql /docker-entrypoint-initdb.d/
```
Step 8. Create [init.sql](./database/init.sql)
```bash
CREATE TABLE IF NOT EXISTS users(
    id SERIAL PRIMARY KEY,
    name TEXT
);
```
Step 9. Create [docker-compose.yml](./docker-compose.yml)
```bash
version: "3.9"

services:

  database:
    build: ./database
    container_name: postgres_db
    restart: always

    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: ananya

    volumes:
      - pgdata:/var/lib/postgresql/data

    networks:
      macvlan_net:
        ipv4_address: 192.168.50.21

    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U admin"]
      interval: 10s
      retries: 5

  backend:
    build: ./backend
    container_name: node_backend
    restart: always

    environment:
      DB_HOST: 192.168.50.21
      POSTGRES_DB: mydb
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: ananya

    depends_on:
      database:
        condition: service_healthy

    networks:
      macvlan_net:
        ipv4_address: 192.168.50.20
      bridge_net: {}      

    ports:
      - "3000:3000"   

volumes:
  pgdata:

networks:
  macvlan_net:
    external: true
  bridge_net:            
    driver: bridge
```
Step 10. Find the network interface
```bash
ip a
```
Step 11. Create network
```bash
docker network create -d macvlan \
  --subnet=192.168.50.0/24 \
  --gateway=192.168.50.1 \
  -o parent=eth0 \
  macvlan_net
```
![](./images/createnetwork.png)

Step 12. Build from compose
```bash
docker-compose build --no-cache
```
![](./images/buildcompose.png)

Step 13. Start services
```bash
docker-compose up -d
```
![](./images/dockercomposeup.png)

Step 13. Insert a user in database
```bash
 curl -X POST http://192.168.50.20:3000/users \
-H "Content-Type: application/json" \
-d '{"name":"Ananya Tiwari"}'
 ```
 Step 14. GET user API
 ```bash
  curl http://192.168.50.20:3000/users
  ```
 ![](./images/post.png)

Step 15. List running containers
```bash
docker ps
```
![](./images/dockerps.png)

Step 16. List Volumes
```bash
docker volume ls
```
![](./images/volumels.png)

Step 17. Inspect network
```bash
docker network inspect macvlan_net
```
![](./images/inspectmacvlan.png)

Step 18. Inspect backend container
```bash
docker inspect node_backend
```
![](./images/inspectbackend.png)

Step 19. Inspect database
```bash
docker inspect postgres_db
```
![](./images/inspectdb.png)

Step 20. Verify data persistance
```bash
docker-compose down
docker-compose up -d
curl http://localhost:3000/users
```
![](./images/volumepersist1.png)
![](./images/volumepersist2.png)
---
---
## Justification for Using localhost Instead of Macvlan IP
Although the Macvlan network was successfully configured and container-to-container communication is functioning correctly, with the backend container able to access the PostgreSQL database using static IP addresses, there are certain limitations observed due to the use of WSL (Windows Subsystem for Linux).

In this setup, Macvlan enables containers to behave as independent devices on the network; however, due to WSL’s virtualized networking architecture, the host system is unable to directly communicate with containers using their Macvlan-assigned IP addresses. This results in connection timeouts when attempting to access the backend service via its static IP from the host machine.

Therefore, despite the correct implementation of Macvlan networking and successful inter-container communication, direct host access using Macvlan IPs is restricted in the WSL environment. To overcome this limitation for testing and demonstration purposes, port mapping and localhost access were used.

1. Macvlan setup
![](./images/just1.png)

2. Container to container communication is working over macvlan
![](./images/just2.png)

3. Databse is accessible
![](./images/just3.png)

4. WSL Limitation
![](./images/just4.png)
Macvlan networking assigns each container a unique IP address, making them behave like separate devices on the LAN. However, due to Linux kernel restrictions, the host cannot directly communicate with these containers. To access container services from the host, port mapping (e.g., using localhost) is used instead.