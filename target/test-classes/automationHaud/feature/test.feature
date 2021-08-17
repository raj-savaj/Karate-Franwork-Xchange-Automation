@parallel=false
Feature:

Background:
* def a = 1
* def fun = function(){ return { country_id:"" } }
* def c = callonce fun

Scenario:
    * print a 
    * set c.country_id = 2
    # the callonce in the background is a snapshot at THAT point in time
    # so the next scenario should "rewind" to that state

Scenario:
    * print a
    * print c