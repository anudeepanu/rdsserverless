terraform {
  backend "s3" {
    bucket = "backendterraformtest"
    key = "indev-dem-emr"
    access_key = "accesskey"
    secret_key = "secretkey"
    region = "ap-south-1"
  }
}
                                        
