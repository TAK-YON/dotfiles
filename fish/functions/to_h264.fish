function to_h264
    ffmpeg -i (path resolve $argv[1]) -vcodec libx264 -acodec copy -crf 27 -preset slower -profile:v high (path change-extension _h264-conv.mp4 $argv[1])
end
