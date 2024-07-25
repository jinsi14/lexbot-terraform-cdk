#!/usr/bin/env python3
import os

import aws_cdk as cdk

from aws_terraform_cdk.s3_bucket_stack import CdkS3Stack


app = cdk.App()
CdkS3Stack(app, "CdkS3Stack")

app.synth()
