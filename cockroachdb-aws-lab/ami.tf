data "aws_ami" "jump" {
  owners = ["amazon"]

  filter {
    name   = "image-id"
    values = ["ami-0b2c9d1f3edcfd709"]
  }
}

output "jump_ami_id" {
  description = "Pinned Amazon Linux 2023 image for the jump host."
  value       = data.aws_ami.jump.id
}

output "jump_ami_name" {
  description = "Release name of the selected image."
  value       = data.aws_ami.jump.name
}