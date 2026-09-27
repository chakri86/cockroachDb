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

resource "aws_iam_role_policy" "jump_describe_instances" {
  name = "crdb-jump-describe-instances"
  role = aws_iam_role.jump.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DescribeInstancesInLabRegion"
        Effect   = "Allow"
        Action   = "ec2:DescribeInstances"
        Resource = "*"

        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}