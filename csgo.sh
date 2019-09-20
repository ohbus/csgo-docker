#!/bin/sh

#change directory
cd $HOME/hlserver

#start server
csgo/srcds_run -game csgo -tickrate 128 -autoupdate -steam_dir ~/hlserver -steamcmd_script ~/hlserver/csgo_ds.txt $@
