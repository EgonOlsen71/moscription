call mospeed ..\basic\cardy.bas -compactlevel=4 -printopt=true -compression=true -generatesrc=true
call mospeed ..\basic\loader.bas
call moscrunch ++loader.prg -addfiles=..\res\moscription.img
call mosm ..\basic\copy.asm