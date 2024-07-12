resource "aws_lambda_function" "ConnectHandler" {
  function_name = "ConnectHandler2FFD52D8"

  # Assuming the IAM role and DynamoDB table are defined elsewhere in your Terraform configuration
  # and their identifiers are ConnectHandlerServiceRole and ConnectionsTable8000B8A1 respectively.
  role = aws_iam_role.ConnectHandlerServiceRole7E4A9B1F.arn

  handler = "index.handler"
  runtime = "nodejs16.x"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.ConnectionsTable8000B8A1.name
    }
  }

  # Inline code is specified directly in the `filename` argument using the `data` and `archive_file` resources.
  # This approach packages the inline code into a ZIP file that Lambda requires.
  depends_on = [
    aws_iam_policy.ConnectHandlerServiceRoleDefaultPolicy7DE94863,
    aws_iam_role.ConnectHandlerServiceRole7E4A9B1F
  ]

  filename         = data.archive_file.ConnectHandler_zip.output_path
  source_code_hash = data.archive_file.ConnectHandler_zip.output_base64sha256
}

# Use the `archive_file` data source to package the inline Lambda function code.
data "archive_file" "ConnectHandler_zip" {
  type        = "zip"
  output_path = "${path.module}/ConnectHandler2FFD52D8.zip"

  source {
    content  = <<-EOT
      const {DynamoDBClient} = require("@aws-sdk/client-dynamodb")
      const {DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb")
      exports.handler = async function(event) {
      
      const client = new DynamoDBClient({});
      const docClient = DynamoDBDocumentClient.from(client);
      const command = new PutCommand({
          TableName: process.env.TABLE_NAME,
          Item: {
             connectionId: event.requestContext.connectionId,
          },
        });
      
      try {
        await docClient.send(command)
        } catch (err) {
          console.log(err)
          return {
            statusCode: 500
          };
        }
          return {
          statusCode: 200,
        };
      }
    EOT
    filename = "index.js"
  }
}

resource "aws_lambda_function" "DisconnectHandler" {
  function_name = "DisconnectHandlerCB7ED6F7"
  role          = aws_iam_role.DisconnectHandlerServiceRoleE54F14F9.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  filename         = data.archive_file.DisconnectHandler_zip.output_path
  source_code_hash = data.archive_file.DisconnectHandler_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.ConnectionsTable8000B8A1.name
    }
  }

  depends_on = [
    aws_iam_policy.DisconnectHandlerServiceRoleDefaultPolicy1800B9E5,
    aws_iam_role.DisconnectHandlerServiceRoleE54F14F9
  ]
}

# Use the `archive_file` data source to package the inline Lambda function code.
data "archive_file" "DisconnectHandler_zip" {
  type        = "zip"
  output_path = "${path.module}/DisconnectHandlerCB7ED6F7.zip"

  source {
    content  = <<-EOT
      const {DynamoDBClient} = require("@aws-sdk/client-dynamodb")
      const {DynamoDBDocumentClient, DeleteCommand } = require("@aws-sdk/lib-dynamodb")
      exports.handler = async function(event) {
      
      const client = new DynamoDBClient({});
      const docClient = DynamoDBDocumentClient.from(client);
      const command = new DeleteCommand({
          TableName: process.env.TABLE_NAME,
          Key: {
             connectionId: event.requestContext.connectionId,
          },
        });
      
      try {
        await docClient.send(command)
        } catch (err) {
          console.log(err)
          return {
            statusCode: 500
          };
        }
          return {
          statusCode: 200,
        };
      }
    EOT
    filename = "index.js"
  }
}

resource "aws_lambda_function" "DefaultHandler" {
  function_name = "DefaultHandler604DF7AC"
  role          = aws_iam_role.DefaultHandlerServiceRole.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  filename         = data.archive_file.DefaultHandler_zip.output_path
  source_code_hash = data.archive_file.DefaultHandler_zip.output_base64sha256

  depends_on = [
    aws_iam_policy_attachment.DefaultHandlerServiceRoleDefaultPolicy2F57C32F,
    aws_iam_role.DefaultHandlerServiceRoleDF00569C
  ]
}

data "archive_file" "DefaultHandler_zip" {
  type        = "zip"
  output_path = "${path.module}/DefaultHandler604DF7AC.zip"

  source {
    content  = <<-EOT
      const {ApiGatewayManagementApiClient, PostToConnectionCommand, GetConnectionCommand} = require("@aws-sdk/client-apigatewaymanagementapi")
      exports.handler = async function(event) {
        let connectionInfo;
        let connectionId = event.requestContext.connectionId;
      
        const callbackAPI = new ApiGatewayManagementApiClient({
          apiVersion: '2018-11-29',
          endpoint: 'https://' + event.requestContext.domainName + '/' + event.requestContext.stage
        }); 

        try {
          connectionInfo = await callbackAPI.send(new GetConnectionCommand(
            {ConnectionId: event.requestContext.connectionId }
          ));
        } catch (e) {
          console.log(e);
        }
      
        connectionInfo.connectionID = connectionId;
      
        await callbackAPI.send(new PostToConnectionCommand(
          {ConnectionId: event.requestContext.connectionId,
            Data:
              'Use the sendmessage route to send a message. Your info:' +
              JSON.stringify(connectionInfo)}
        ));
        return {
          statusCode: 200,
        };
      };
    EOT
    filename = "index.js"
  }
}

