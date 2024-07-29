from aws_cdk import (
    Stack,
)
from constructs import Construct
from .s3_bucket_stack import S3Bucket
from .lambda_function_stack import LambdaFunction

class AwsTerraformCdkStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Create Lambda Function
        lambda_function = LambdaFunction(self, "MyLambdaFunctionConstruct").function

        # Create S3 Bucket and pass Lambda Function
        s3_bucket = S3Bucket(self, "MyS3BucketConstruct", lambda_function=lambda_function)
