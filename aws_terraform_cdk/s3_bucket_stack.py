import aws_cdk as cdk
from aws_cdk import aws_s3 as s3
from constructs import Construct

class CdkS3Stack(cdk.Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create an S3 bucket
        bucket = s3.Bucket(
            self,
            "aws-cdk-bucket-jinsi",
            versioned=True,
            removal_policy=cdk.RemovalPolicy.DESTROY,
            auto_delete_objects=True
        )

        cdk.CfnOutput(self, "BucketName", value=bucket.bucket_name)
