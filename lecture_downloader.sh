#download directory
dest=/home/darren/Documents/comp4610/lecture_notes/

#download the index file
wget --quiet --no-remove-listing http://cs.anu.edu.au/student/comp4610/notes/  

#check that file exists
if [ ! -f index.html ]; then
    echo "File not found!"
else
    
    #add all pdf file names to an array
    arr=($(cat index.html | grep -o -P '(?<=HREF=).*(?=.pdf)' | cut -d'"' -f 2))

    no_files_downloaded=1    

    #download the file if it doesn't already exist
    for i in ${arr[@]}; do
        url="http://cs.anu.edu.au/student/comp4610/notes/$i"
        filedir="$dest$i"
        if [ ! -f $filedir ]; then
            no_files_downloaded=0
            echo "Downloading $i"
            wget --quiet --directory-prefix=$dest $url
        fi
    done
    if [ $no_files_downloaded -eq 1 ]; then
        echo "No files downloaded"
    fi
fi

rm index.html
