import Levenshtein
import sys

str1 = sys.argv[1]
str2 = sys.argv[2]

print(Levenshtein.distance(str1, str2))
