resource "aws_iam_role" "jump" {
  name        = "crdb-jump-role"
  description = "Allows the lab jump host to use AWS Systems Manager."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = "cockroachdb-aws-lab"
  }
}

resource "aws_iam_role_policy_attachment" "jump_ssm" {
  role       = aws_iam_role.jump.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "jump" {
  name = "crdb-jump-profile"
  role = aws_iam_role.jump.name
}