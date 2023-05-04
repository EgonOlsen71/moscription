del moscription_AD.d64
c1541 -format moscription,bq d64 moscription_AD.d64
call compile.cmd
call ..\build\c1541 ..\build\moscription_AD.d64 -write ++loader-c.prg moscription,p
call ..\build\c1541 ..\build\moscription_AD.d64 -write ++cardy-c.prg game,p
call ..\build\c1541 ..\build\moscription_AD.d64 -write copy.prg copy,p
call ..\build\c1541 ..\build\moscription_AD.d64 -write ..\basic\chars chars,p
cd ..\build
cd ..\seq
for %%f in (*.*) do call :add "%%f"
cd ..\build
goto :EOF

:add
..\build\c1541 ..\build\moscription_AD.d64 -write %1 %1,s
