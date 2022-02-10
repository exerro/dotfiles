
# set LS colours
set -gx LS_COLORS "no=00:fi=36:di=33:ln=32:pi=01;30:do=01;30:bd=01;30:cd=01;30:or=31:so=01;30:su=01;30:sg=01;30:tw=01;30:ow=33:st=01;30:ex=36:mi=31"

# set shell colours
set -gx fish_color_normal          normal
set -gx fish_color_command         yellow
set -gx fish_color_keyword         purple
set -gx fish_color_quote           blue
set -gx fish_color_redirection     blue --dim --italic
set -gx fish_color_end             purple --dim --italic
set -gx fish_color_error           brred
set -gx fish_color_param           cyan
set -gx fish_color_comment         green --dim --italic
set -gx fish_color_operator        cyan --bold
set -gx fish_color_escape          purple
set -gx fish_color_autosuggestion  'brblack'
set -gx fish_color_cancel          -r
set -gx fish_color_search_match    '--background=white' '--dim'
set -gx fish_color_history_current --bold
set -gx fish_color_valid_path      --underline
