#!/bin/bash
docker build --build-arg user_id=$(id -u) --build-arg USER=$(whoami) --build-arg NAME=deimos --rm -t dtc-jackal-deimos:whisper-test .