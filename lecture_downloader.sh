arr=( $(wget -d -r -np -N --spider -e robots=off --no-check-certificate \
  https://cs.anu.edu.au/student/comp4610/notes/ \
  2>&1 | grep " -> " | grep -Ev "\/\?C=" | sed "s/.* -> //" | grep ".pdf" | uniq))


echo ${arr[@]}

for i in ${arr[@]}; do
    a=$(basename $i)
    if [ ! -f $a ]; then
        echo "$a not found! Downloading File"
        wget $i
    else
        echo "$a already exists" 
    fi
done
mv *.pdf lecture_notes/
rm -rf cs.anu.edu.au/
