#!/bin/bash
pactl load-module module-null-sink sink_name="obs_sink" sink_properties=device.description="obs_audio"

pactl load-module module-loopback source=obs_sink.monitor sink=alsa_output.pci-0000_00_1f.3.analog-stereo rate=44100
