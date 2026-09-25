provider "aws" {
  region  = "us-east-1"
  profile = "crdb-lab"

  allowed_account_ids = ["297646182738"]
}