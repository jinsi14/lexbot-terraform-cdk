from aws_cdk import (
    Stack,
    aws_s3 as s3,  # Import S3 module
    RemovalPolicy,  # Import RemovalPolicy if not imported
)
from constructs import Construct
from .s3_bucket_stack import S3Bucket

class AwsTerraformCdkStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here
        s3_bucket = S3Bucket(self, "MyS3BucketConstruct")
        # example resource
        # queue = sqs.Queue(
        #     self, "LexbotTerraformCdkQueue",
        #     visibility_timeout=Duration.seconds(300),
        # )
