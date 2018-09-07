ruleset twilio {
  meta {
    configure using account_sid = ""
                    auth_token = ""
    provides
        send_sms,
        messages
  }
 
  global {
    send_sms = defaction(to, from, message) {
       base_url = <<https://#{account_sid}:#{auth_token}@api.twilio.com/2010-04-01/Accounts/#{account_sid}/>>
       http:post(base_url + "Messages.json", form = {
                "From":from,
                "To":to,
                "Body":message
            })
    }
    messages = function(to, from, page_size, page_num, page_token) {
      PageSize = "?PageSize=" + ((page_size == null) => "50" | page_size);
      PageNum = "&Page=" + ((page_num == null) => "0" | page_num);
      PageToken = (page_token == null) => "" | ("&PageToken=" + page_token);
      To = (to != null) => ("&To="+ to) |"" ;
      From = (from != null) => ("&From="+ from) |"" ;
      base = "https://" + account_sid + ":" + auth_token + "@api.twilio.com/2010-04-01/Accounts/" + account_sid + "/Messages.json";
      http:get(base + PageSize + To + From + PageNum + PageToken )
    }
  }
}
