@echo off

set PATH=%PATH%;C:\Program Files\Git\usr\bin

doskey ls=ls --color $*
doskey vim=neovide $*

%USERPROFILE%\.python\Scripts\activate.bat
