ruleset use_twilio {
  meta {
    use module lesson_keys
    use module twilio alias twilio
        with account_sid = keys:twilio{"account_sid"}
             auth_token =  keys:twilio{"auth_token"}
  }
 
  rule test_send_sms {
    select when test new_message
    twilio:send_sms(event:attr("to"),
                    event:attr("from"),
                    event:attr("message")
                   )
  }
  rule test_messages {
    select when test get_messages
    pre {
    response = twilio:messages(event:attr("to"), event:attr("from"), event:attr("page_size"), event:attr("page_num"), event:attr("page_token"));
    json_response = response{"content"}.decode();
    }
        send_directive("Messages test", json_response)
  }
}
