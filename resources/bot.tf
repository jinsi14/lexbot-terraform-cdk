
//create s3 bucket
resource "aws_s3_bucket" "lex_bot_bucket" {
  bucket = "my-lex-bot-s3-bucket-${var.prefix_region}-${var.env}"
}

resource "aws_s3_bucket_versioning" "lex_bot_bucket" {
  bucket = aws_s3_bucket.lex_bot_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

//upload bot zip file in s3 bucket
resource "aws_s3_object" "lex_bot_zip" {
  bucket = aws_s3_bucket.lex_bot_bucket.id
  key    = "lex-bots/digiflowersv2-DRAFT-B56L841Z2E-LexJson.zip"
  source = "./config/digiflowersv2-DRAFT-B56L841Z2E-LexJson.zip"
  etag   = filemd5("./config/digiflowersv2-DRAFT-B56L841Z2E-LexJson.zip")
}

//create bot
resource "awscc_lex_bot" "my_lex_bot" {
  name                   = "my-lex-bot-${var.prefix_region}-${var.env}"
  auto_build_bot_locales = true
  role_arn               = aws_iam_role.lex_execution_role.arn
  data_privacy = {
    child_directed = false
  }
  idle_session_ttl_in_seconds = 300
  bot_file_s3_location = {
    s3_bucket     = aws_s3_bucket.lex_bot_bucket.id
    s3_object_key = aws_s3_object.lex_bot_zip.key
  }
  bot_tags = [
    {
      key   = "environment"
      value = "${var.env}"
    }
  ]
}


//create bot version

resource "awscc_lex_bot_version" "my_lex_bot_version" {
  bot_id     = awscc_lex_bot.my_lex_bot.id
  bot_version_locale_specification = [
    {
      locale_id = "en_US"
      bot_version_locale_details = {
        source_bot_version = "DRAFT"
      }
    }
  ]
}


//create lex bot alias
resource "awscc_lex_bot_alias" "my_lex_bot_alias" {
  bot_alias_name = "live"
  bot_id         = awscc_lex_bot.my_lex_bot.id
  bot_version    = awscc_lex_bot_version.my_lex_bot_version.bot_version
  sentiment_analysis_settings = {
    detect_sentiment = false
  }
  bot_alias_locale_settings = [
    {
      locale_id = "en_US"
      bot_alias_locale_setting = {
        enabled = true
        code_hook_specification = null
      }
    }
  ]
}
