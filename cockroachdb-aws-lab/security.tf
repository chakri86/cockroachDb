resource "aws_security_group" "jump" {
  name        = "crdb-jump-sg"
  description = "Jump host access through AWS Systems Manager"
  vpc_id      = data.aws_vpc.lab.id

  tags = {
    Name    = "crdb-jump-sg"
    Project = "cockroachdb-aws-lab"
  }
}

resource "aws_vpc_security_group_egress_rule" "jump_ipv4" {
  security_group_id = aws_security_group.jump.id
  description       = "Allow outbound IPv4 traffic for the lab"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
