#!/usr/bin/env bash

none="none"
bg_dark="#1f2335"
fg_dark="#a9b1d6"
fg_gutter="#3b4261"
blue="#7aa2f7"

black="#15161e"

set -g message-style "fg=${blue},bg=${fg_gutter}"
set -g message-command-style "fg=${blue},bg=${fg_gutter}"

set -g pane-border-style "fg=${fg_gutter}"
set -g pane-active-border-style "fg=${blue}"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=${blue},bg=${bg_dark}"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style $none
set -g status-right-style $none

set -g status-left "#[fg=${black},bg=${blue},bold] #S #[fg=${blue},bg=${bg_dark},nobold,nounderscore,noitalics]"

# set -g status-right '#{?#{music_status},♫ #{music_status} #{artist}: #{track} |,""} #(gitmux "#{pane_current_path}") | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '♫ #{music_status} #{artist}: #{track} | #(gitmux "#{pane_current_path}") | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# tm_tunes="#{?#{tm_tunes_present},#{track} #{artist},}"
# set -g status-right $tm_tunes

# tm_tunes="#{?#{tm_tunes_present},♫ #{artist}: #{track} |,}"
# tm_tunes="#{?#{tm_tunes_present},♫ #{track} #{artist},}"
# set -g status-right $tm_tunes
# spotify_playing="#{track}"
# spotify_track="♫ #{music_status} #{artist}: #{track} |"
# set -g status-right '#{?#{spotify_playing},♫ #{music_status} #{artist}: #{track} |,""} #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '#{?#{spotify_playing},#{spotify_track},} #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
set -g status-right '♫ #{music_status} #{artist}: #{track} | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'

# #{?COND,A,B}
# set -g status-right '#{?#{track},♫ #{music_status} #{artist}: #{track} |, hi}'

setw -g window-status-activity-style "underscore,fg=${fg_dark},bg=${bg_dark}"
setw -g window-status-separator ""
setw -g window-status-style "${none},fg=${fg_dark},bg=${bg_dark}"
setw -g window-status-format "#[fg=${bg_dark},bg=${bg_dark},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${bg_dark},bg=${bg_dark},nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=${bg_dark},bg=${fg_gutter},nobold,nounderscore,noitalics]#[fg=${blue},bg=${fg_gutter},bold] #I  #W #F #[fg=${fg_gutter},bg=${bg_dark},nobold,nounderscore,noitalics]"
