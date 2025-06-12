#!/bin/bash

source /opt/ros/noetic/setup.bash
source /home/dtc/ws/devel/setup.bash

roscore &
sleep 5

if [ "$RUN" = true ]; then
    echo "[MIC_TO_WHISPER] Launching microphone transcriber"
    roslaunch mic_to_whisper mic_to_whisper.launch --wait timeout:=10
else
    echo "[MIC_TO_WHISPER] RUN set to false, not launching microphone transcriber"
fi
