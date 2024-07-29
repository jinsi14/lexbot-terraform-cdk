from aws_cdk import (
    aws_lambda as _lambda,
    CfnOutput,
    Duration, 
)
from constructs import Construct

class LambdaFunction(Construct):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Create a Lambda function
        self.function = _lambda.Function(
            self,
            "AwsCdkTestLambdaFunction",
            function_name="aws-cdk-python-function-test",
            runtime=_lambda.Runtime.PYTHON_3_12,  
            handler="lambda_handler.handler",  
            code=_lambda.Code.from_asset("lambda"),  # Location of the Lambda code
            timeout=Duration.minutes(5)
        )

        # Output the function name
        CfnOutput(self, "LambdaFunctionName", value=self.function.function_name)
