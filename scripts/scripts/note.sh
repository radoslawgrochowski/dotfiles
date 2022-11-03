# make new file in my notes projects 
# and open it in nvim 

date=$(date '+%Y_%m_%d')
word1=$(shuf -n1  /usr/share/dict/words)
word2=$(shuf -n1  /usr/share/dict/words)
default_input="${word1}_${word2}"

read -p "Enter filename [${default_input}]: " input 

filename="${date}_${input:-$default_input}.md"

notes_path="$HOME/Projects/notes/"

nvim ${notes_path}${filename}

