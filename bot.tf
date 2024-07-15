resource "aws_lexv2models_bot" "example" {
  name = "digiexamplelexv2"
  data_privacy {
    child_directed = false
  }
  idle_session_ttl_in_seconds = 300
  role_arn                    = aws_iam_role.lex_execution_role.arn

  tags = {
    created_by = "terraform"
  }
}

resource "aws_lexv2models_bot_locale" "example" {
  bot_id                           = aws_lexv2models_bot.example.id
  bot_version                      = "DRAFT"
  locale_id                        = "en_US"
  n_lu_intent_confidence_threshold = 0.40

  voice_settings {
    voice_id = "Kendra"
    engine   = "standard"
  }
}

resource "aws_lexv2models_bot_version" "example_version" {
  bot_id = aws_lexv2models_bot.example.id
  locale_specification = {
    "en_US" = {
      source_bot_version = "DRAFT"
    }
  }
}

resource "aws_lexv2models_intent" "example" {
  bot_id      = aws_lexv2models_bot.example.id
  bot_version = aws_lexv2models_bot_version.example_version.bot_version
  name        = "botens_namn"
  locale_id   = aws_lexv2models_bot_locale.example.locale_id
}

resource "aws_lexv2models_slot_type" "test" {
  bot_id      = aws_lexv2models_bot.example.id
  bot_version = aws_lexv2models_bot_version.example_version.bot_version
  name        = "test"
  locale_id   = aws_lexv2models_bot_locale.example.locale_id
}
