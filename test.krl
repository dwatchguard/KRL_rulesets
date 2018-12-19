ruleset EventModeling{
  meta{
    name "Event Modeling"
    author "Torrey Kelly"
    
  }
    rule rule1 {
      select when tweet received where event:attr("body").match(re#healthcare#)
    }
}
