# ffmpeg-stabilizer
This is a small tool to facilitate people that a re 'losers' in making videos - i.e., have shaky hands. In this **tool-chain**
you can stablize a set of videos (using ffmpeg). We use the beauty of make, that is able to check if your specific file has already been stabilized. It's a very simple makefile, yet powerful.

1. Cut specific sections within for a set of videos
1. Stablize them using a Makefile that also checks if it already has been stablized or not.
1. Check if you made some impact with the **before-and-after** (merged).

# Usage
> Construct a csv file that looks like
~~~CSV
filename,ffmpeg-options # don't include this header..
converted/MVI_9154.MOV,-ss 00:00:27 -t 00:00:31
converted/MVI_9154.MOV,-ss 00:00:51 -t 00:00:53
converted/MVI_9144.MOV,-ss 00:00:26 -t 00:00:36
converted/MVI_9144.MOV,-ss 00:00:56 -t 00:00:60
converted/MVI_9372.MOV,-ss 00:00:22 -t 00:00:26
converted/MVI_9152.MOV,-ss 00:00:18 -t 00:00:34
converted/MVI_9153.MOV,-ss 00:00:32 -t 00:00:35
converted/MVI_9256.MOV,-ss 00:00:10 -t 00:00:14
converted/MVI_9255.MOV,-ss 00:00:03 -t 00:00:08
converted/MVI_9257.MOV,""
~~~
With this, you specify a filename and the options you want to pass to the ffmpeg script. Currently it only supports the time
options. Note that later we could add the parameters like the level of stablization.

You can simply create the files using `ls video/*.MOV > list.csv`
Then, run the following command:
~~~shell
./stablize.sh list.csv
~~~

## Notes
On ubuntu you probably need to change `ffmpeg` to `libav`, and it should work then. This is however not tested yet.

## Disclaimer
This tool has been 'hacked' together, but is nonetheless very useful. Don't complain about readability, it's Bash.. get over it ;)


Example output to check if you're doing it a bit right.
~~~
ffmpeg -i video/MVI_9028.MOV  -vf vidstabdetect=shakiness=8:accuracy=15:result=converted/MVI_9028-stb.trf -f null -
Options

===
No time limit
ffmpeg version 3.4 Copyright (c) 2000-2017 the FFmpeg developers
  built with Apple LLVM version 8.1.0 (clang-802.0.42)
  configuration: --prefix=/usr/local/Cellar/ffmpeg/3.4 --enable-shared --enable-pthreads --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags= --host-ldflags= --enable-gpl --enable-libmp3lame --enable-libvidstab --enable-libx264 --enable-libxvid --enable-opencl --enable-videotoolbox --disable-lzma
  libavutil      55. 78.100 / 55. 78.100
  libavcodec     57.107.100 / 57.107.100
  libavformat    57. 83.100 / 57. 83.100
  libavdevice    57. 10.100 / 57. 10.100
  libavfilter     6.107.100 /  6.107.100
  libavresample   3.  7.  0 /  3.  7.  0
  libswscale      4.  8.100 /  4.  8.100
  libswresample   2.  9.100 /  2.  9.100
  libpostproc    54.  7.100 / 54.  7.100
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'video/MVI_9028.MOV':
  Metadata:
    major_brand     : qt
    minor_version   : 537331968
    compatible_brands: qt  CAEP
    creation_time   : 2017-03-09T23:23:19.000000Z
  Duration: 00:04:02.16, start: 0.000000, bitrate: 44883 kb/s
    Stream #0:0(eng): Video: h264 (Constrained Baseline) (avc1 / 0x31637661), yuvj420p(pc, smpte170m/bt709/bt709), 1920x1080, 43342 kb/s, 25 fps, 25 tbr, 25k tbn, 50k tbc (default)
    Metadata:
      creation_time   : 2017-03-09T23:23:19.000000Z
    Stream #0:1(eng): Audio: pcm_s16le (sowt / 0x74776F73), 48000 Hz, stereo, s16, 1536 kb/s (default)
    Metadata:
      creation_time   : 2017-03-09T23:23:19.000000Z
Stream mapping:
  Stream #0:0 -> #0:0 (h264 (native) -> wrapped_avframe (native))
  Stream #0:1 -> #0:1 (pcm_s16le (native) -> pcm_s16le (native))
Press [q] to stop, [?] for help
[swscaler @ 0x7fb2cb837200] deprecated pixel format used, make sure you did set range correctly
[vidstabdetect @ 0x7fff596d5c88] Fieldsize: 112, Maximal translation: 154 pixel
[vidstabdetect @ 0x7fff596d5c88] Number of used measurement fields: 65 out of 65
[vidstabdetect @ 0x7fff596d5c88] Fieldsize: 32, Maximal translation: 32 pixel
[vidstabdetect @ 0x7fff596d5c88] Number of used measurement fields: 392 out of 392
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80] Video stabilization settings (pass 1/2):
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]      shakiness = 5
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]       accuracy = 15
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]       stepsize = 6
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]    mincontrast = 0.250000
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]         tripod = 0
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]           show = 0
[Parsed_vidstabdetect_0 @ 0x7fb2c8700a80]         result = converted/MVI_9028-stb.trf
Output #0, null, to 'pipe:':
  Metadata:
    major_brand     : qt
    minor_version   : 537331968
    compatible_brands: qt  CAEP
    encoder         : Lavf57.83.100
    Stream #0:0(eng): Video: wrapped_avframe, yuv420p, 1920x1080, q=2-31, 200 kb/s, 25 fps, 25 tbn, 25 tbc (default)
    Metadata:
      creation_time   : 2017-03-09T23:23:19.000000Z
      encoder         : Lavc57.107.100 wrapped_avframe
    Stream #0:1(eng): Audio: pcm_s16le, 48000 Hz, stereo, s16, 1536 kb/s (default)
    Metadata:
      creation_time   : 2017-03-09T23:23:19.000000Z
      encoder         : Lavc57.107.100 pcm_s16le
~~~
