# make new file in my notes projects 
# and open it in nvim 

date=$(date '+%Y_%m_%d')
default_input=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')

read -p "Enter filename [${default_input}]: " input 

filename="${date}_${input:-$default_input}.md"

notes_path="$HOME/Projects/notes/"

nvim ${notes_path}${filename}

