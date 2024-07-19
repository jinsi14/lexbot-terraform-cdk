resource "aws_iam_role" "lex_execution_role" {
  name = "my-lex-bot-role-${var.prefix_region}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lexv2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test" {
  role       = aws_iam_role.lex_execution_role.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonLexFullAccess"
}