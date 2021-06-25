#!/usr/local/bin/zsh

interesting_part=$(cat $1 | grep '\(fp_length\|fp_depth\|conv_width\)')
fp_depths=($(echo $interesting_part | awk '{if ($1=="\"fp_depth\":") print $2}' | sed 's/,//'))
fp_lengths=($(echo $interesting_part | awk '{if ($1=="\"fp_length\":") print $2}' | sed 's/,//'))
conv_widths=($(echo $interesting_part | awk '{if ($1=="\"conv_width\":") print $2}' | sed 's/,//'))

round () {
	printf '%.*f' 0 $1
}
if [[ ${fp_depths[1]} == $(round ${fp_depths[2]}) && \
      ${fp_lengths[1]} == $(round ${fp_lengths[2]}) && \
      ${conv_widths[1]} == $(round ${conv_widths[2]}) ]]; then
	echo 'OK'
else
	echo 'Not OK'
fi
