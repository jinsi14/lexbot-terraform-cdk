import aws_cdk as cdk
from aws_cdk import aws_s3 as s3
from constructs import Construct


def s3_bucket(self, scope: Construct, id: str, **kwargs) -> None:
    bucket = s3.Bucket(
        self,
        id = "aws-cdk-test-bucket",
        bucket_name="aws-cdk-bucket-jinsi",
        versioned=True,
        removal_policy=cdk.RemovalPolicy.DESTROY,
        auto_delete_objects=True
    )
    cdk.CfnOutput(self, "BucketName", value=bucket.bucket_name)
