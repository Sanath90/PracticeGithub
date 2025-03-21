# backend.hcl
bucket         = "uniquedelete"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-state-lock-471112834153-us-east-1"
