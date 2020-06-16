# Task1-hybrid-multi-cloud-
## Task Description:
1.Create the key and security group which allow the port 80.


2. Launch EC2 instance.


3. In this Ec2 instance use the key and security group which we have created in step 1.


4. Launch one Volume (EBS) and mount that volume into /var/www/html


5. Developer have uploded the code into github repo also the repo has some images.


6. Copy the github repo code into /var/www/html


7. Create S3 bucket, and copy/deploy the images from github repo into the s3 bucket and change the permission to public readable.


8 Create a Cloudfront using s3 bucket(which contains images) and use the Cloudfront URL to  update in code in /var/www/html



### Steps followed

### 1.CREATING A PROFILE FOR SSH LOGIN :
![Screenshot (86)](https://user-images.githubusercontent.com/60479969/84745503-4f7ff400-afd2-11ea-8cf3-bc03bb037079.png)




 ### 2.CREATING A KEY & SECURITY GROUP:
![Screenshot (87)](https://user-images.githubusercontent.com/60479969/84745507-50b12100-afd2-11ea-9c7d-94922fda6546.png)

### 3.CREATING EC2 INSTANCE AND REMOTE LOGIN:
![Screenshot (88)](https://user-images.githubusercontent.com/60479969/84745509-5149b780-afd2-11ea-8b20-6c6570421013.png)

### 4.CREATING EBS VOLUME, ATTACH TO THE INSTANCE,MOUNT &CLONE CODE FROM GIT-HUB REPO
![Screenshot (89)](https://user-images.githubusercontent.com/60479969/84745511-5149b780-afd2-11ea-8453-f0b9b037db3a.png)

### 5.CREATING S3 BUCKET & UPLOADING THE IMAGE IN BUCKET:
![Screenshot (90)](https://user-images.githubusercontent.com/60479969/84745513-51e24e00-afd2-11ea-893f-a67bef458139.png)

### 6.CREATING CLOUD FRONT DISTRIBUTION (S3 as ORIGIN):
![Screenshot (92)](https://user-images.githubusercontent.com/60479969/84745516-53137b00-afd2-11ea-9087-d8ea34a38c22.png)
![Screenshot (93)](https://user-images.githubusercontent.com/60479969/84745517-53137b00-afd2-11ea-9406-68da0ff08e9e.png)

##  created webpage using Terraform
![Screenshot (99)](https://user-images.githubusercontent.com/60479969/84746097-1b590300-afd3-11ea-976d-2476b2f5cd6a.png)
### Glance of my home page
![Screenshot (100)](https://user-images.githubusercontent.com/60479969/84746099-1c8a3000-afd3-11ea-8831-75357a1c29ae.png)
### Glance of my home page
![Screenshot (102)](https://user-images.githubusercontent.com/60479969/84746101-1d22c680-afd3-11ea-9b43-4301c2cf6838.png)
### Glance of my home page
![Screenshot (101)](https://user-images.githubusercontent.com/60479969/84746103-1e53f380-afd3-11ea-9c35-39fbc7ed2a75.png)


### terraform validate for validating the syntax of the code in file with extension .tf
### terraform apply (-auto-approve) for applying all the resources adding them
### terraform destroy (-auto-approve) for destroying all the resources
