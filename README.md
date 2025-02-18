# labff
Audacity labels -> ffmpeg input file converter
A simple tool for making score videos without a video editor.

demo video:
https://www.youtube.com/watch?v=5XGn_MWeuvw

Put source audio, images and labels.txt files into project folder
Start _makevid to compile video and wait for output.mp4 (check _YOUTUBE folder)

You can use labff.exe in standalone mode if you'd like to convert the labels file

Default resolution is 3840x2160 @10fps, it can be changed by editing _makevid.bat

Any audio formats are accepted, the default input file is audio.mp3, it can be changed by editing _makevid.bat

Based on andrewmole's idea: https://gist.github.com/ajlee2006/76c08102eba36895d843274198b285b2
sproc by CMaj7: https://github.com/edwardx999/ScoreProcessor/releases
