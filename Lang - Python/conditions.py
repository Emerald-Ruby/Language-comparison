PROMPT: str = "Please enter one of the following"
TAB: str = "\t"
TYPE: str = "type"
TS: str = "typescript"
JS: str = "javascript"
ANYTHING: str = "Or anything!"

print(PROMPT)
print(TAB, TYPE)
print(TAB, TS)
print(TAB, JS)
print(TAB, ANYTHING)

selection: str = input(">> ").rstrip()

if selection == "":
    print("That's nothing!")
elif selection == TYPE:
    print("Safety!")
elif selection == JS or selection == TS:
    print("Ew ew ew ew away!")
else:
    print("Hmmm yes I see,", selection)