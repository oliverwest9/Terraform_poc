resource "aws_dynamodb_table" "connections_table" {
  name           = "ConnectionsTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "connectionId"

  attribute {
    name = "connectionId"
    type = "S"
  }
}