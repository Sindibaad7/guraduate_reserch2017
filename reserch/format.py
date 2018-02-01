import sys
import re

text = sys.argv[1]
new_text1 = text.replace(' ', '')
new_text2 = new_text1.replace('	', '')

checker = new_text2[0:7]

if checker == ">>>>>>>":
 print("a")
elif checker == "=======":
 print("a")
else:
 print(new_text2)
