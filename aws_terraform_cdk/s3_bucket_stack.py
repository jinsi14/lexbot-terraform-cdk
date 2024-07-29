from aws_cdk import (
    aws_s3 as s3,
    aws_s3_notifications as s3n,  # Import the S3 notifications module
    CfnOutput,
    RemovalPolicy,
)
from constructs import Construct
from aws_cdk.aws_lambda import IFunction

class S3Bucket(Construct):

    def __init__(self, scope: Construct, construct_id: str, lambda_function: IFunction, **kwargs) -> None:
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

        # Create a notification for S3 bucket to trigger the Lambda function
        notification = s3n.LambdaDestination(lambda_function)
        self.bucket.add_event_notification(s3.EventType.OBJECT_CREATED, notification)

        # Output the bucket name
        CfnOutput(self, "BucketName", value=self.bucket.bucket_name)
