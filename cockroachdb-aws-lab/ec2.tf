resource "aws_instance" "jump" {
  ami           = data.aws_ami.jump.id
  instance_type = "t3.small"

  subnet_id                   = data.aws_subnet.jump.id
  vpc_security_group_ids      = [aws_security_group.jump.id]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.jump.name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "crdb-jump"
    Project = "cockroachdb-aws-lab"
  }

  depends_on = [
    aws_iam_role_policy_attachment.jump_ssm,
    aws_vpc_security_group_egress_rule.jump_ipv4
  ]
}

output "jump_instance_id" {
  description = "EC2 instance ID used to connect through Session Manager."
  value       = aws_instance.jump.id
}