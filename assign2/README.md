# Task: Deploy a Simple Web Application (Apache httpd)
Step 1: Run a Pod
```bash
kubectl run apache-pod -- image=httpd
```
Check:
```bash
kubectl get pods
```
![](./images/img1.png)

---
Step 2: Inspect Pod
```bash
kubectl describe pod apache-pod
```
Focus:
· container image = httpd
· ports (default 80)
· events
![](./images/img2.png)

---
Step 3: Access the App
```bash
kubectl port-forward pod/apache-pod 8081:80
```
![](./images/img3.png)
Open:
```bash
http://localhost:8081

```
![](./images/img4.png)

---
Step 5: Create Deployment
```bash
kubectl create deployment apache --image=httpd
```
Check:
```bash
kubectl get deployments
kubectl get pods
```
![](./images/img5.png)

---
Step 6: Expose Deployment
```bash
kubectl expose deployment apache --port=80 --type=NodePort
```
Access again:
```bash
kubectl port-forward service/apache 8082:80
```
![](./images/img6.png)
Open:
```bash
http://localhost:8082
```
![](./images/img7.png)