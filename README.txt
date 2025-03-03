To make this list, I grabbed a list of top most common words and filtered things I didn't want

Got rid of duplicates, made them lowercase, words without vowels, words with diacritics, etc
```bash
cat top-2500.txt | rg -v "^#" | sort -u -f | sed 's/.*/\L&/' | rg -v "^[^ia]$" | rg -i "[aeiouy]+" | rg "^\'" -v | rg -i --pcre2 "^(.)\1+$" -v | rg "'$" -v | rg "[^a-zA-Z']" -v > top-2500.txt2
cat top-2500.txt2 > top-2500.txt && rm top-2500.txt2 
```
