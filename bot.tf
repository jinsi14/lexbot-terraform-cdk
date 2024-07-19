# Create Lex V2 Bot
resource "aws_lexv2models_bot" "example" {
  name = "digiexamplelexv2"
  data_privacy {
    child_directed = false
  }
  idle_session_ttl_in_seconds = 300
  role_arn = aws_iam_role.lex_execution_role.arn

  tags = {
    created_by = "terraform"
  }
}

# Define Bot Locale ("en_US" in this example)
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

# Create a new version for the bot
resource "aws_lexv2models_bot_version" "test" {
  bot_id = aws_lexv2models_bot.example.id
  locale_specification = {
    "en_US" = {
      source_bot_version = "DRAFT"
    }
  }
}

# Define the Intent
resource "aws_lexv2models_intent" "example" {
  bot_id      = aws_lexv2models_bot.example.id
  bot_version = aws_lexv2models_bot_locale.example.bot_version
  name        = "botens_namn"
  locale_id   = aws_lexv2models_bot_locale.example.locale_id
}

# Create the Slot
resource "aws_lexv2models_slot" "example" {
   bot_id      = aws_lexv2models_bot.example.id
  bot_version = aws_lexv2models_bot_version.test.bot_version
  intent_id   = aws_lexv2models_intent.example.id
  locale_id   = aws_lexv2models_bot_locale.example.locale_id
  name          = "FlowerTypes"

  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      message_group {
        message {
          plain_text_message {
            value = "What type of flowers would you like to order?"
          }
        }
      }
      max_retries = 2
      allow_interrupt = true
    }
  }
}

  #confirmation_setting  {
  #  data.local_file.order_flowers_intent_json
  #} jsondecode(data.local_file.order_flowers_intent_json.content)
#}