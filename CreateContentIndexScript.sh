#!/bin/bash

USER_NAME=`git config --list | grep user.name | cut -f 2 -d "="`
USER_URL=`echo "https://github.com/$USER_NAME/"`
REPOSITORY_NAME=`pwd | rev | cut -d '/' -f 1 | rev`
PROCESSED_REPOSITORY_NAME=`echo $REPOSITORY_NAME | tr '[A-Z]' '[a-z]' | tr ' ' '-'`
PROCESSED_RNWS=`echo $REPOSITORY_NAME | tr '[A-Z]' '[a-z]' | tr -d ' '`
echo "# [go back to Overview](https://github.com/c4arl0s)" > README.md
echo "" >> README.md
echo "# [$REPOSITORY_NAME - Content](https://github.com/c4arl0s/$PROCESSED_RNWS#go-back-to-overview)" >> README.md
echo "" >> README.md
INDEX=0
cat $1 | while read LINE
do 
    let INDEX=$INDEX+1
    # FINAL_LINE = ENUMERATED_LINE + (USER_URL+PROCESSED_RNWS+MASTER_LINE)
    ENUMERATED_LINE=`echo "$INDEX. [ ] [$INDEX. $LINE]"`
    MASTER_LINE=`echo "#$INDEX-$LINE" | tr ' ' '-' | tr -d '.'| tr -d ']()'  | tr -d '[' | tr -d ':' | tr -d '\47' | tr -d '>' | tr -d ',' | tr -d '/' | tr -d '\46' | tr -d '$' | tr -d ';' | tr -d '|' | tr -d '\302' | tr -d '\251' | tr -d '\303' | tr -d '\140' | tr -d '’' | tr -d '?' | tr -d '!'| tr -d '%' | tr -d '@'`
    FINAL_LINE=`echo "$ENUMERATED_LINE($USER_URL$PROCESSED_RNWS$MASTER_LINE)"`
    # replace white spaces with -, replace upper case with lower case, remove ('), \47 is the octal value of it (')
    echo $FINAL_LINE
    echo "$FINAL_LINE" >> README.md
    gh issue create --title "$INDEX $LINE" --body "$INDEX $LINE"
done
echo "" >> README.md
echo "# [$REPOSITORY_NAME](https://github.com/c4arl0s/$PROCESSED_RNWS#$PROCESSED_REPOSITORY_NAME---content)" >> README.md
echo "" >> README.md
INDEX=0
cat $1 | while read LINE
do 
    let INDEX=$INDEX+1
    ENUMERATED_LINE=`echo "# $INDEX. [$LINE](https://github.com/c4arl0s/$PROCESSED_RNWS#$PROCESSED_REPOSITORY_NAME---content)"` 
    echo "$ENUMERATED_LINE"
    echo "$ENUMERATED_LINE" >> README.md
done
