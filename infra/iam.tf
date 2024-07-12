  resource "aws_iam_role" "ConnectHandlerServiceRole7E4A9B1F" {
    name               = "ConnectHandlerServiceRole7E4A9B1F"
    assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        }
      }
    ]
  })
  }
  
  resource "aws_iam_policy" "ConnectHandlerServiceRoleDefaultPolicy7DE94863" {
    name        = "ConnectHandlerServiceRoleDefaultPolicy7DE94863"
    description = "Policy for ConnectHandlerServiceRole7E4A9B1F"
  
    policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
            {
                "Action": [
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "dynamodb:DeleteItem",
                "dynamodb:DescribeTable"
                ],
                "Effect": "Allow",
                "Resource": [
                aws_dynamodb_table.ConnectionsTable8000B8A1.arn,
                aws_dynamodb_table.ConnectionsTable8000B8A1.arn/*Ref: AWS::NoValue*/
                ]
            }
            ]
        })
  }

  resource "aws_iam_role" "DisconnectHandlerServiceRoleE54F14F9" {
    name               = "DisconnectHandlerServiceRoleE54F14F9"
    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
            "Service": "lambda.amazonaws.com"
            }
        }
    ]
  })
  }

  resource "aws_iam_policy" "DisconnectHandlerServiceRoleDefaultPolicy1800B9E5" {
    name        = "DisconnectHandlerServiceRoleDefaultPolicy1800B9E5"
    policy      =  jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
            "Action": [
            "dynamodb:BatchWriteItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:DescribeTable"
            ],
            "Effect": "Allow",
            "Resource": [
            aws_dynamodb_table.ConnectionsTable8000B8A1.arn,
            aws_dynamodb_table.ConnectionsTable8000B8A1.arn/*Ref: AWS::NoValue*/
            ]
      }
    ]
  })
  }
  
#   resource "aws_iam_role_policy_attachment" "disconnect_handler_service_role_attachment" {
#     role       = aws_iam_role.disconnect_handler_service_role.name
#     policy_arn = aws_iam_policy.disconnect_handler_service_role_default_policy.arn
#   }


#     resource "aws_iam_role" "send_message_handler_service_role" {
#     name               = "SendMessageHandlerServiceRole5F523417"
#     assume_role_policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Effect": "Allow",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         }
#       }
#     ]
#   }
#   EOF
#   }


#   resource "aws_iam_policy" "default_handler_service_role_default_policy" {
#     name        = "DefaultHandlerServiceRoleDefaultPolicy2F57C32F"
#     policy      = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "execute-api:ManageConnections",
#         "Effect": "Allow",
#         "Resource": "arn:aws:execute-api:${aws_region}:${aws_account_id}/*/POST/@connections/*"
#       },
#       {
#         "Action": "execute-api:ManageConnections",
#         "Effect": "Allow",
#         "Resource": "arn:aws:execute-api:${aws_region}:${aws_account_id}/*/GET/@connections/*"
#       }
#     ]
#   }
#   EOF
#   }

#   resource "aws_iam_role_policy_attachment" "default_handler_service_role_attachment" {
#     role       = aws_iam_role.default_handler_service_role.name
#     policy_arn = aws_iam_policy.default_handler_service_role_default_policy.arn
#   }

#   resource "aws_iam_policy" "manage_connections" {
#     name        = "manageConnections7F91357B"
#     policy      = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "execute-api:ManageConnections",
#         "Effect": "Allow",
#         "Resource": "arn:aws:execute-api:${var.region}:${var.account_id}:*/*/POST/@connections/*"
#       }
#     ]
#   }
#   EOF
#   }

#   resource "aws_iam_policy" "send_message_handler_service_role_default_policy" {
#     name        = "SendMessageHandlerServiceRoleDefaultPolicyF9D10585"
#     policy      = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "dynamodb:BatchGetItem",
#           "dynamodb:GetRecords",
#           "dynamodb:GetShardIterator",
#           "dynamodb:Query",
#           "dynamodb:GetItem",
#           "dynamodb:Scan",
#           "dynamodb:ConditionCheckItem",
#           "dynamodb:DescribeTable"
#         ],
#         "Effect": "Allow",
#         "Resource": [
#           aws_dynamodb_table.connections_table.arn,
#           aws_dynamodb_table.connections_table.arn
#         ]
#       }
#     ]
#   }
#   EOF
#   }

#   resource "aws_iam_role_policy_attachment" "send_message_handler_service_role_attachment" {
#     role       = aws_iam_role.send_message_handler_service_role.name
#     policy_arn = aws_iam_policy.send_message_handler_service_role_default_policy.arn
#   }

#     resource "aws_iam_role" "default_handler_service_role" {
#     name               = "DefaultHandlerServiceRoleDF00569C"
#     assume_role_policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Effect": "Allow",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         }
#       }
#     ]
#   }
#   EOF
#     managed_policy_arns = [
#       "arn:${aws_partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#     ]
#   }