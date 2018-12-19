ruleset EventModeling{
  meta{
    name "Event Modeling"
    author "Torrey Kelly"
    
  }
    rule rule1 {
      select when tweet received where event:attr("body").match(re#healthcare#)
    }
    rule rule2 {
      select when email received where event:attr("body").match(re#BYU#)
         and event:attr("body").match(re#football#)
    }
    rule rule3 {
      select when count 4 (tweet received where event:attr("body").match(re#healthcare#)) within 4 hours 
    }
    
    rule rule4 {
       select when tweet received where event:attr("body").match(re#healthcare#) 
          before email where event:attr("subj").match(re#healthcare#) or event:attr("body").match(re#healthcare#)
    }
    
    rule rule5 {
      select when email received event:attr("from") re#(.*)# setting (sender) 
          and repeat 5 (email:received where event:attr("from").match(("re#" + sender + "#").as("RegEXP"))) within 20 minutes
    }
    rule rule6 {
      select when stock update event:attr("percent") > 2 event:attr() re#(.*) setting (symbol)
        after tweet received where event:attr("body").match(("re#" + symbol + "#" ).as("RegExp"))
    }
    rule rule7 {
      select when web pageview url re#(www.google.com|www.Yahoo!.com|www.MSNBC.com|www.CNN.com|www.KSL.com)# setting (site)
      after web pageview url re#(www.google.com|www.Yahoo!.com|www.MSNBC.com|www.CNN.com|www.KSL.com)# setting (site2)
      and site != site2
      
    }
}
