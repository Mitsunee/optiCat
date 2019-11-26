#!/bin/bash

# A helper for optipng
# Made by Mitsunee (https://www.mitsunee.com)
# LICENSE: WTFPL (http://www.wtfpl.net/txt/copying/)

### CONFIG START ###

typeset -A config
config=(
	[optiLevel]="-o2" # Change to value from 1 to 7
	[path]="/home/$USER/Pictures" # Enter a custom path if you wish (has to be absolute)
	[showCommandList]="y" # If this is y the list of available commands is shown on startup
)

### CONFIG END ###

# Check that the config dir exists
if [ ! -d ~/.config/optiCat ]; then
	mkdir ~/.config/optiCat
	touch ~/.config/optiCat/queue
fi

# Check that a queue file exists
if [ ! -f ~/.config/optiCat/queue ]; then
	touch ~/.config/optiCat/queue
fi

function printVersion() {
	echo "optiCat - version 1.0.0"
}

function printHelp() {
	echo "Use one of the following commands:"
	echo "- add      (add pictures to the queue)"
	echo "- run      (run the queue)"
	echo "- length   (display the current queue length)"
	echo "- purge    (delete the current queue)"
	echo "- help     (show this list)"
	echo "- version  (show version)"
	echo "- exit     (quit the program)"
}

function menuSelect() {
	printVersion
	if [ "${config[showCommandList]}" == "y" ]; then
		printf "\n"
		printHelp
	fi

	while (true) do
		printf "\n> " && read userinput

		printf "\n"
		if [ "$userinput" == "exit" ]; then
			break;
		fi
		handleCommands "$userinput"
	done
}

function menuByArg() {
	# Special behaviour for adding
	if [ "$1" == "add" ] && [ $# -gt 1 ]; then
		shift
		addToQueue "$*"
		exit
	fi
	# Special behaviour for -v, --version and version args
	if [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
		printVersion
		exit
	fi
	# Standardized behaviour for the rest
	handleCommands "$*"
}

function handleCommands() {
	case $1 in
	"add")
		menuQueueAdd;;
	"run")
		runQueue;;
	"length")
		printQueueLength;;
	"purge")
		purgeQueue;;
	"help")
		printHelp;;
	"version")
		printVersion;;
	*)
		echo "Unrecognized command";;
	esac
}

function menuQueueAdd() {
	echo "Enter the filename of the picture. Leave blank to stop adding pictures."

	while (true); do
		printf "\nFilename: " && read filename
		if [ "$filename" == "" ]; then
			break
		fi
		addToQueue "$filename"
	done
}

function addToQueue() {
	printf "$*\n" >> ~/.config/optiCat/queue
	echo "Added to queue: $*"
}

function runQueue() {
	if [ ! "$(printQueueLength)" == "0 Picture(s) queued" ]; then
		pushd "${config[path]}" &> /dev/null
		cat ~/.config/optiCat/queue | xargs -n 1 find . -iname | xargs -n 1 -I {} printf "%q\n" "{}" | xargs -n 1 optipng ${config[optiLevel]} && printf "" > ~/.config/optiCat/queue
		popd &> /dev/null
	fi
}

function printQueueLength() {
	echo "$(wc -l < ~/.config/optiCat/queue) Picture(s) queued"
}

function purgeQueue() {
	printf "Are you sure? (y/n): "
	read yn
	if [ "$yn" == "y" ]; then
		rm ~/.config/optiCat/queue
		touch ~/.config/optiCat/queue
		echo "Purged queue"
	else
		echo "Canceled purging queue"
	fi
}

if [ "$(which optipng)" == "" ]; then
	echo "You must have optipng installed to use this script"
	exit
fi

if [ -z "$1" ]; then
	menuSelect
else
	menuByArg $*
fi
