ruleset use_twilio_v2 {
  meta {
    use module lesson_keys
    use module twilio_v2 alias twilio
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
      messages = twilio:get_messages(event:attr("to"),event:attr("from")).klog("messages");
    }
        send_directive(messages)
  }
}
