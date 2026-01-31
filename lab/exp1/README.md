# EXPERIMENT 1: Comparision of Virtual Machines (VMs) and Containers using Ubuntu and Nginx

---

## Objectives
1. To understand the conceptual and practical differences between Virtual Machines and Containers.

2. To install and configure a Virtual Machine using VirtualBox and Vagrant on Windows.

3. To install and configure Containers using Docker inside WSL.

4. To deploy an Ubuntu-based Nginx web server in both environments.

5. To compare resource utilization, performance, and operational characteristics of VMs and Containers.
---

## Part A: Virtual Machine (Windows)

---

### Step 1: Install VirtualBox

1. Download VirtualBox from the official website.
2. Run the installer and keep default options.
3. Restart the system if prompted.

---

### Step 2: Install Vagrant
 1. Download Vagrant for Windows

![install vagrant](./images/PartA%20images/1.png)

2. Verify installation :
```bash
vagrant --version
```
![verify vagrant installation](./images/PartA%20images/2.png)

---

### Step 3: Create Ubuntu VM using Vagrant
1. Create a new directory:
```bash
mkdir vm-lab
cd vm-lab
```
2. Initialize Vagrant with Ubuntu box:
```bash
vagrant init hashicorp/bionic64
```
![init](./images/PartA%20images/3.png)

3. Start the VM:
```bash
vagrant up
```
![start vm](./images/PartA%20images/4.png)

4. Access the VM:
```bash
 vagrant ssh
 ```
 ![access vm](./images/PartA%20images/5.png)
---

### Step 4: Install Nginx inside VM
```bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
```
---
### Utilization Matrix in Running State :
![utilization matrix in running state](./images/PartA%20images/7.png)

---

### Step 5: Verify Nginx

```bash
curl localhost
```
![verify nginx](./images/PartA%20images/6.png)

---

### Step 6: Stop and Remove VM
```bash
vagrant halt
vagrant destroy
```
![stop and halt](./images/PartA%20images/8.png)

---

### Utilization Matrix in Stop State :
![utilization matrix in stop state](./images/PartA%20images/9.png)

---
### Step 7: Remove VM
```bash
vagrant destroy
```
![vagrant destroy](./images/PartA%20images/10.png)

---

---
## Part B: Containers using WSL (Windows)

---
   ### Step 1: Install WSL 2
   ```bash
   wsl --install
   ```
   ---
   ### Step 2: Install Ubuntu on WSL
   ```bash
wsl --install -d Ubuntu
```
---
### Step 3: Install Docker Engine inside WSL
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker $USER
```
Logout and login again to apply group changes.
![install docker engine](./images/PartB%20images/img1.png)

---
### Step 4: Run Ubuntu Container with Nginx
```bash
docker pull ubuntu
```
![pull ubuntu](./images/PartB%20images/img2.png)

```bash
docker run -d -p 8080:80 --name nginx-container nginx
```
![run container](./images/PartB%20images/img3.png)

---
### Step 5: Verify Nginx in Container
```bash
curl localhost:8080
```
![verify nginx](./images/PartB%20images/img4.png)

---
### Resource Utilization Observation

1. VM Observation :
```bash
free -h
```
![free -h](./images/PartB%20images/img5.png)

---
```bash
Sudo apt install htop
```
![install htop](./images/PartB%20images/img6.png)

---
```bash
htop
```
![htop](./images/PartB%20images/img7.png)

---
```bash
systemd-analyze
```
![systemd analyze](./images/PartB%20images/img8.png)

---
2. Container Observation :
```bash
docker stats
free -h
```
![docker stats](./images/PartB%20images/img9.png)

---
---
## Result
The experiment demonstrates that containers are significantly more lightweight and resource-efficient compared to virtual machines, while virtual machines provide stronger isolation and full OS-level abstraction.

---

## Conclusion
Virtual Machines are suitable for full OS isolation and legacy workloads, whereas Containers are ideal for microservices, rapid deployment, and efficient resource utilization.


