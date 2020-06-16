provider "aws" {
  region = "ap-south-1"
  profile = "ayushi"
}




resource "aws_security_group" "tasksg11" {
 name = "tasksg11"
 description = "Allow port 80 and 22 inbound traffic"


 ingress {
 description = "SSH"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = [ "0.0.0.0/0" ]
 }
 ingress {
 description = "HTTP"
 from_port = 80
 to_port = 80
 protocol = "tcp"
 cidr_blocks = [ "0.0.0.0/0" ]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
 Name = "tasksg11"
 }
}

resource "aws_instance" "myins1" {
  ami           = "ami-0447a12f28fddb066"
  instance_type = "t2.micro"
  key_name = "key1"
  security_groups = [ aws_security_group.tasksg11.name]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/user/Downloads/key1.pem")
    host     = aws_instance.myins1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }

  tags = {
    Name = "myos1"
  }

}
resource "null_resource" "null1" {
 

  provisioner "local-exec" {
    command = "echo ${aws_instance.myins1.public_ip} > publicip.txt"
  }
}
output "my_public_ip"{
value= aws_instance.myins1.public_ip
}


resource "aws_ebs_volume" "myebs1" {
  availability_zone = aws_instance.myins1.availability_zone
  size              = 1

  tags = {
    Name = "myhdtera"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdb"
  volume_id   = aws_ebs_volume.myebs1.id
  instance_id = aws_instance.myins1.id
}
resource "null_resource" "nullRemote" {
  depends_on = [
    aws_volume_attachment.ebs_att,
    aws_s3_bucket_object.teraimage

  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    host = aws_instance.myins1.public_ip
    private_key = file("C:/Users/user/Downloads/key1.pem")
    
  }
  provisioner "remote-exec" {
    inline = [
       "sudo mkfs.ext4 /dev/xvdb",
       "sudo mount /dev/xvdb /var/www/html",
       "sudo yum install git -y",
       "sudo rm -rf /var/www/html/*",
       "sudo git clone https://github.com/ayushi-1408/Task1-hybrid-multi-cloud-.git   /temp_repo",
       "sudo cp -rf /temp_repo/* /var/www/html",
     
      
    ]
  }
}

resource "aws_s3_bucket" "buc1" {
  bucket = "terabuc"
  acl    = "public-read" #bucket level safty
  

versioning {
    enabled = true
  }

  tags = {
    Name        = "Mybuc"
    Environment = "Dev"
  }
}


locals {
  s3_origin_id = "myS3Origin"
}

 
resource "aws_s3_bucket_object" "teraimage" {
  bucket = aws_s3_bucket.buc1.bucket
  key    = "covid.jpg"
   
 # object level saftyyes
 
  source ="C:/Users/user/Desktop/website1/covid.jpg" 
 acl  ="public-read"
}


resource "aws_cloudfront_distribution" "s3cloudfront" {
enabled             = true
  is_ipv6_enabled     = true
  origin {
  
    domain_name = "${aws_s3_bucket.buc1.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"

  }



  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"

  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
connection {
   type="ssh"
user ="ec2-user"
private_key=file("C:/Users/user/Downloads/key1.pem")
host=aws_instance.myins1.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo su << EOF",
                           "echo \"<img src='http://${self.domain_name}/${aws_s3_bucket_object.teraimage.key} \" >> /var/www/index.html",
"EOF",
    ]
  }
}

 