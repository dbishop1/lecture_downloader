#download the index file
wget --quiet --no-remove-listing http://cs.anu.edu.au/student/comp4610/notes/  

#check that file exists
if [ ! -f index.html ]; then
    echo "File not found!"
else
    
    #add all pdf file names to an array
    arr=($(cat index.html | grep -o -P '(?<=HREF=).*(?=.pdf)' | cut -d'"' -f 2))

    #download the file if it doesn't already exist
    for i in ${arr[@]}; do
        url="http://cs.anu.edu.au/student/comp4610/notes/$i"
        if [ ! -f $i ]; then
            echo "Downloading $i"
            wget --quiet $url
        fi
    done
fi

rm index.html
