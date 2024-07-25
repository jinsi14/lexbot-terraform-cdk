import aws_cdk as core
import aws_cdk.assertions as assertions

from aws_terraform_cdk.s3_bucket_stack import CdkS3Stack

# example tests. To run these tests, uncomment this file along with the example
# resource in lexbot_terraform_cdk/lexbot_terraform_cdk_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = CdkS3Stack(app, "aws-cdk-stack")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
