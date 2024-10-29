let PROMPT  : string = "Please enter one of the following"
let TAB     : string = "\t"
let TYPE    : string = "type"
let TS      : string = "typescript"
let JS      : string = "javascript"
let ANYTHING: string = "Or anything"

print(PROMPT)
print(TAB + TYPE)
print(TAB + TS)
print(TAB + JS)
print(TAB + ANYTHING)

let selection: string = get_line(">> ")

if selection == "":
    print "That\'s nothing"
elif selection == TYPE:
    print "Safety!"
elif selection == TS or selection == JS:
    print "Ew ew ew ew away!"
else:
    print "Hmm yes I see, " + selection