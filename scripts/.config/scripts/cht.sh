#!/usr/bin/env bash
languages=$(echo "golang c cpp typescript javascript rust poweron" | tr " " "\n")
core_utils=$(echo "find xargs sed awk tr curl less more tail grep" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "GIMME YOUR QUERY:" query

if echo "$languages" | grep -qs $selected; then 
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl -s cht.sh/$selected~$query | less -R"
fi
