#!/usr/bin/env fish
function to_avif_all
set -g extensions .webp .jpg .jpeg .png .gif
set -g files $(ls --color never ./**/*$extensions)
set -g saved 0



echo -e "You're about to recursively convert $(set_color brred)EVERY $(set_color -i blue)$extensions$(set_color normal) in $PWD.\nAre you sure you want to do this?\n"
read --prompt-str="Y/n (Case sensitive) > " resp

if test $resp != "Y"
    exit 1
end

if test $PWD = $HOME
    set_color -u brred; echo -e "ABSOLUTELY SURE?\nYou're in HOME"; set_color normal

    read --prompt-str="YY/n > " resp
    if test $resp != "YY"
        exit 1
    end
end

for f in $files
    set avif $(path change-extension .avif $f)
    ffmpeg -nostdin -hide_banner -i $f -vf format=yuv444p10le -c:v libaom-av1 -crf 20 -cpu-used 1 -usage allintra -aom-params tune=iq $avif

    set -l prev_size (stat -c %s $f)
    set -l aft_size (stat -c %s $avif)

    set -g saved (math  "$saved + ($prev_size - $aft_size)")

    set -l move_dir $(path dirname $f)
    if test -d $move_dir
        mkdir -p ./Converted/$move_dir
    end
    mv -n $f ./Converted/$f
end

set_color blue
echo -e "\n\n\n=== Conversions Finished ==="
echo "Saved $(set_color brgreen; math -s 2 "($saved / 1024) / 1024 ")MB"
end
