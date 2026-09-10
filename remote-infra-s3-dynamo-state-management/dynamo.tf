resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "terraform-dynamodb-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }
 
  tags = {
    Name        = "terraform-dynamodb-state-table"
    Environment = "Dev"
  }
}