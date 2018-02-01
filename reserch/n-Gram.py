import difflib
import sys
import unicodedata
import mojimoji
import ngram


str1 = mojimoji.zen_to_han(sys.argv[1])
str2 = mojimoji.zen_to_han(sys.argv[2])

#s = difflib.SequenceMatcher(None, str1, str2).ratio()
s = int(round(ngram.NGram.compare(str1, str2,N=3)*100, 0))
#s = ngram.NGram.compare(str1, str2, N=3)


print(s)
#print str1, "<~>", str2
#print "match ratio:", s, "\n"

