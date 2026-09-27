terraform {
  backend "s3" {
    bucket       = "crdb-tfstate-297646182738-use1-20260926"
    key          = "cockroachdb-aws-lab/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}