#!/usr/bin/bash

echo -e "\n\t\t\t-------- install_ffmpeg.sh started --------\n\t\t\t" && \
    cd /home/pi && \
    echo "/home/pi: " && \
    echo -e "\tdownloading ffmpeg ..." && \
        sudo cp -p /home/pi/iptalk_resources/packages/ffmpeg-release-armel-32bit-static.tar.xz /home/pi/ffmpeg.tar.xz && \
    echo -e "\tffmpeg downloaded. Unpackaging ffmpeg ..." && \
        tar -Jxf ffmpeg.tar.xz && \
        sudo mv /home/pi/ffmpeg-3.3.4-armel-32bit-static /home/pi/ffmpeg
    echo -e "\tffmpeg unpackaged. Static ffmpeg is ready for use." && \
echo -e "\n\t\t\t-------- install_ffmpeg.sh finished --------\n\t\t\t"