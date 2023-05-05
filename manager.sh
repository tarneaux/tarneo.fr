#! /bin/bash
# Path: manager.sh
# Author: tarneo
# Dependencies: Hugo, Fzf, NVim
# This script is used to manage hugo posts.

set -e

usage() {
	echo "Usage: ./manager.sh [new|edit|del]"
}

cd `dirname $0`

ex() {
	# Clean up and exit
	cd - > /dev/null
	exit $1
}

[[ "$1" == "cd" ]] && {
	# Exit without coming back
	exit 0
}

# If we will be modifying articles, start the hugo server, but in a tmux session
[[ "$1" == "new" ]] || [[ "$1" == "edit" ]] && {
	# If the server is already running, kill it
	[[ $(tmux ls | grep hugo) ]] && {
		tmux kill-session -t hugo
	}
	# Start the server in a tmux session
	tmux new-session -d -s hugo "hugo server --noHTTPCache -D --disableFastRender"
	echo "Hugo server started in tmux session 'hugo'"
}

# If we are creating a new post, we need to enter the title
[[ "$1" == "new" ]] && {
	echo "Enter the title of the post: "
	read title
	# If the user didn't enter a title, exit
	if [ -z "$title" ]; then
		ex 1
	fi
	# Replace spaces with underscores
	title=$(echo "$title" | sed 's/ /_/g')
	# Replace non-alphanumeric characters with underscores
	title=$(echo "$title" | sed 's/[^a-zA-Z0-9]/_/g')
	# Replace capital letters with lowercase
	title=$(echo "$title" | tr '[:upper:]' '[:lower:]')
	# Create the post
	hugo new "posts/$title.md"
	# Open the post in nvim
	nvim "content/post/$title.md"
	ex 0
}

[[ "$1" == "edit" ]] || [[ "$1" == "del" ]] && {
	# Otherwise, we need to select the post
	# Get the list of posts
	posts=$(ls content/posts | sed 's/\.md//g')
	# Select the post
	post=$(echo "$posts" | fzf)
	# If the user didn't select a post, exit
	if [ -z "$post" ]; then
		ex 1
	fi
	[[ "$1" == "edit" ]] && {
		# Open the post in nvim
		nvim "content/posts/$post.md"
	}

	[[ "$1" == "del" ]] && {
		# Delete the post
		rm "content/posts/$post.md"
	}
	ex 0
}

# If we got here, something went wrong
usage
ex 1

