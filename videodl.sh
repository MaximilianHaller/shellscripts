#!/bin/bash

URL=$1
start=$2
stop=$3
let length=$3-$2
echo $length


function startstopformat {

case $(echo -n $start | wc -c) in
	1) start="00:00:0$start";;
	2) start="00:00:$start";;
	3) start="00:00$start";;
	4) start="00:0$start";;
	5) start="00:$start";;
	6) start="00$start";;
	7) start="0$start";;
esac

case $(echo -n $stop | wc -c) in
	1) stop="00:00:0$stop";;
	2) stop="00:00:$stop";;
	3) stop="00:00$stop";;
	4) stop="00:0$stop";;
	5) stop="00:$stop";;
	6) stop="00$stop";;
	7) stop="0$stop";;
esac

}
startstopformat

rm -f ~/temp/youtube-dl/*

function usage {
	echo "Usage:   ./videodl.sh videourl starttime endtime"
	echo "Example: ./videodl.sh youtube.com 0:30 1:30"
}
#ensure youtube-dl is installed
function installytdl {

	if ! command -v youtube-dl &> /dev/null
	then
	    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
		sudo chmod a+rx /usr/local/bin/youtube-dl
	fi

}
# ensure ffmpeg is installed
function installffmpeg {

	if ! command -v ffmpeg &> /dev/null
	then
	    sudo apt install ffmpeg
	fi

}

installytdl 
installffmpeg


function download {
	youtube-dl -f 22 -o "~/temp/youtube-dl/dl.%(ext)s" $URL
}

function cut {
	filename=$(ls ~/temp/youtube-dl)
	ffmpeg -ss $start -i temp/youtube-dl/$filename -to $stop -vcodec copy -acodec copy newfile.mp4
}

download
#usage
cut