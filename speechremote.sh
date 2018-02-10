#!/bin/bash
trap "exit" INT
rm -r ./voice/*.wav
cp ./voice/0.old ./voice/0.wav
mkdir -p ./voice/
n=0

obs &
google-chrome https://www.youtube.com/live_dashboard &
google-chrome http://www.speechchat.com/ &

cvlc --one-instance --global-key-next '.' ./voice/$n.wav &
while true; do
  n=$(($n+1))
  rec $n.wav silence 1 0.01 3% 1 2.0 3% 
  mv $n.wav ./voice/
  play ./voice/0.wav
  cvlc --one-instance --global-key-next '.' ./voice/$n.wav &
  pid[0]=$!
done ; fg
pid[1]=$!
trap "kill ${pid[0]} ${pid[1]}; exit 1" INT
wait
