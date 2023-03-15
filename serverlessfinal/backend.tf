terraform {
  backend "s3" {
    bucket = "backendterraformtest"
    key = "indev-dem-emr"
    access_key = "AKIATXQ6PBLM6G6OMAFM"
    secret_key = "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"
    region = "ap-south-1"
  }
}
                                        
