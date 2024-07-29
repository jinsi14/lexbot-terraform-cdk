from aws_cdk import (
    aws_s3 as s3,
    CfnOutput,
    RemovalPolicy,
)
from constructs import Construct

class S3Bucket(Construct):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Create an S3 bucket
        self.bucket = s3.Bucket(
            self,
            "AwsCdkTestBucket",
            bucket_name="aws-cdk-bucket-test",
            versioned=True,
            removal_policy=RemovalPolicy.DESTROY,
            auto_delete_objects=True,
        )

        # Output the bucket name
        CfnOutput(self, "BucketName", value=self.bucket.bucket_name)
