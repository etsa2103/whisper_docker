# Whisper Overview
This module does speech-to-text inference with the open-ai [whisper](https://github.com/openai/whisper). The structure is based on Jason hughes' whisper code (https://github.com/jhughes50/dtc-jackal/tree/1ab620210488aa55472882c8f567aa50f3538780/whisper) 

mic_node: Listens to /jackal_teleop/trigger topic. The message on the trigger topic is how many seconds the mic should wait before recording audio. After waiting for the speaker message to play, audio is recorded from a specified input device using sounddevice and published as a std_msgs/Int16MultiArray on the /mic_audio topic.

whisper_node: Subscribes to /mic_audio, decodes and transcribes the audio using Whisper, and publishes the resulting text as a single accumulated string on the /whisperer/text topic.

## Running Standalone 
To run this standalone run the following:
 - build docker image: `./build.bash`
 - run docker container: `./run.bash`
 
### Configure input device 
- First run `./join.bash` to enter the container.
- Next, find the index of your input device by running the following:
 `python3 -c "import sounddevice as sd; print(sd.query_devices())"`
- To find the parameters of your input device run the following(Replace <device_index>):
`python3 -c "import sounddevice as sd; print(sd.query_devices(<device_index>))"`
- Update the launch file with these parameters

### View transcribed text
- First run ./join.bash to enter the container
- To view the full transcription as it updates, run the following:
`rosrun mic_to_whisper transcription_viewer_node.py`

## Notes
- Make sure the mic you are using is not set as the computers active input or output device. This gave me problems. 
- To test trigerr run `rostopic pub /jackal_teleop/trigger std_msgs/UInt8 "data: 4"`
- Important to resample audio back to 16 kHz for whisper to work well.