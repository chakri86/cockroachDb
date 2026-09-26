data "aws_vpc" "lab" {
  id = "vpc-046d75b10e2d73a42"
}

data "aws_subnet" "jump" {
  id     = "subnet-00a82000f9dd7fa9a"
  vpc_id = data.aws_vpc.lab.id
}

output "jump_subnet_id" {
  description = "Existing subnet selected for the jump host."
  value       = data.aws_subnet.jump.id
}
