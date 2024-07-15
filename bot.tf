resource "aws_lex_bot" "example_bot" {
  name              = "exampleBot"
  description       = "Example Lex Bot"
  child_directed    = false
  locale            = "en-US"
  voice_id          = "Joanna"
  process_behavior  = "BUILD"

  intent {
    intent_name    = aws_lex_intent.example_intent.name
    intent_version = aws_lex_intent.example_intent.version
  }

  abort_statement {
    message {
      content_type = "PlainText"
      content      = "Sorry, I could not understand. Could you please repeat that?"
    }
  }
}

resource "aws_lex_intent" "example_intent" {
  name        = "ExampleIntent"
  description = "Example Intent"
  sample_utterances = ["Hello", "Hi"]
  
  fulfillment_activity {
    type = "ReturnIntent"
  }

  slot {
    name        = "ExampleSlot"
    slot_type   = "AMAZON.Person"
    slot_constraint = "Required"
    value_elicitation_prompt {
      message {
        content_type = "PlainText"
        content      = "Who is this message for?"
      }
      max_attempts = 3
    }
  }
}

resource "aws_lex_bot_alias" "example_bot_alias" {
  name        = "exampleAlias"
  bot_name    = aws_lex_bot.example_bot.name
  bot_version = "$LATEST"
}

resource "aws_lex_slot_type" "example_slot_type" {
  name        = "ExampleSlotType"
  description = "Example Slot Type"
  enumeration_value {
    value = "Person"
  }
}
