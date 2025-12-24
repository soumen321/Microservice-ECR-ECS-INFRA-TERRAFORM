terraform {
  backend "s3" {
    
    bucket         = "aiops-log-bucket-demo"
    key            = "terraform.tfstate"     # confirm exact path
    region         = "us-east-1"             # confirm region
    #dynamodb_table = "terraform-locks"       # if used
    encrypt        = true                    # if true, check KMS policy

  }
}