from aws_cdk import (
    aws_lex as lex,
    CfnOutput,
)
from constructs import Construct
import aws_cdk.aws_s3 as s3  # Import S3

class LexBot(Construct):
    def __init__(self, scope: Construct, construct_id: str, s3_bucket: s3.IBucket, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Create the Lex bot
        lex_bot = lex.CfnBot(
            self,
            "LexBot",
            data_privacy={
                "ChildDirected": False
            },
            idle_session_ttl_in_seconds=300,
            name="MyLexBot",
            role_arn="arn:aws:iam::767252029631:role/admin_role",  # Update with your role ARN
            auto_build_bot_locales=True,
            bot_file_s3_location=lex.CfnBot.S3LocationProperty(
                s3_bucket=s3_bucket.bucket_name,  # Use the passed S3 bucket's name
                s3_object_key="digiflowersv2-DRAFT-OVHEJNTMWY-LexJson.zip"  # The key should match the uploaded file
            )
        )


        # Create a bot version
        bot_version = lex.CfnBotVersion(
            self,
            "LexBotVersion",
            bot_id=lex_bot.ref,
            bot_version_locale_specification=[
                lex.CfnBotVersion.BotVersionLocaleSpecificationProperty(
                    bot_version_locale_details=lex.CfnBotVersion.BotVersionLocaleDetailsProperty(
                        source_bot_version="DRAFT"
                    ),
                    locale_id="en_US"
                )
            ],
            description="Bot version for MyLexBot"
        )

        # Create a bot alias
        bot_alias = lex.CfnBotAlias(
            self,
            "LexBotAlias",
            bot_alias_name="MyLexBotAlias",
            bot_id=lex_bot.ref,
            bot_version=bot_version.attr_bot_version,
            sentiment_analysis_settings={
                "DetectSentiment": False
            }
        )

        # Output the bot ID and alias ARN
        CfnOutput(self, "BotName", value=lex_bot.name)
        CfnOutput(self, "BotAliasArn", value=bot_alias.attr_arn)

