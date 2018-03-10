#!/usr/bin/bash

FFMPEG_TARXZ=./packages/ffmpeg-release-armel-32bit-static.tar.xz
FFMPEG_DEST=/home/pi
FFMPEG_ORI=/home/pi/ffmpeg-3.3.4-armel-32bit-static
FFMPEG_NEW=/home/pi/ffmpeg

echo -e "\n\t\t\t-------- install_ffmpeg.sh started --------\n\t\t\t" && \
    if [ -d "$FFMPEG_NEW" ]; then
        sudo rm -rf $FFMPEG_NEW
    fi && \
    tar -Jxf $FFMPEG_TARXZ -C $FFMPEG_DEST && \  # 解压到指定文件夹 DEST , 得到 FFMPEG_ORI
    sudo mv $FFMPEG_ORI $FFMPEG_NEW && \  # ORI 重命名为 NEW , ORI 消失
echo -e "\n\t\t\t-------- install_ffmpeg.sh finished --------\n\t\t\t"