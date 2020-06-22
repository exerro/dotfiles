#!/usr/bin/env bash

function reload {
	source ~/.bashrc
}

function title {
   echo -ne "\033]0;$*\007"
}
