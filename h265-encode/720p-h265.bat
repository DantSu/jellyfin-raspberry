@echo off
chcp 65001
setlocal enabledelayedexpansion

SET paths[0]="Abby Hatcher, Fuzzly Catcher\Saison 01"
SET paths[0]="Abby Hatcher, Fuzzly Catcher\Saison 02"
SET paths[1]="Gabby's Dollhouse\Saison 01"
SET paths[1]="Gabby's Dollhouse\Saison 02"
SET paths[1]="Gabby's Dollhouse\Saison 03"
SET paths[1]="Gabby's Dollhouse\Saison 04"
SET paths[1]="Gabby's Dollhouse\Saison 05"
SET paths[1]="Gabby's Dollhouse\Saison 06"
SET paths[1]="Gabby's Dollhouse\Saison 07"
SET paths[1]="Gabby's Dollhouse\Saison 08"
SET paths[1]="Gabby's Dollhouse\Saison 09"
SET paths[1]="Gabby's Dollhouse\Saison 10"
SET paths[1]="Gabby's Dollhouse\Saison 11"
SET paths[1]="My Little Pony - Friendship Is Magic\Saison 09"
SET paths[1]="My Little Pony - Make Your Mark\Saison 01"
SET paths[1]="My Little Pony - Make Your Mark\Saison 02"
SET paths[1]="My Little Pony - Make Your Mark\Saison 03"
SET paths[1]="My Little Pony - Make Your Mark\Saison 04"
SET paths[1]="Princess Power\Saison 01"
SET paths[1]="Princess Power\Saison 02"
SET paths[1]="Sunny Bunnies\Saison 01"
SET paths[1]="Unicorn Academy\Saison 01"
SET paths[1]="Unicorn Academy\Saison 02"
SET paths[1]="Unicorn Academy\Saison 03"

SET pathPos=0

:SymLoop
IF DEFINED paths[%pathPos%] (
    SET pathRelative=!paths[%pathPos%]:"=!
    REM "
    ECHO "Paths n. %pathPos% : !pathRelative!"
    SET pathWilcard="Z:\Jeunesse\!pathRelative!\*.*"
    FOR %%i IN (!pathWilcard!) DO (
      SET filePath=%%i
      SET name=%%~ni
      SET ext=%%~xi

      CALL :transcode "%%i" "!pathRelative!" "!name!!ext!"
    )
    SET /a pathPos+=1
    GOTO :SymLoop
)

PAUSE
GOTO :eof

:transcode

SET pathSrc=%~1
SET pathDst=%~2
SET fileName=%~3
SET fileExt=%fileName:~-4%
SET filePathDst=%pathDst%\%fileName%

IF NOT %fileExt% == .mkv IF NOT %fileExt% == .mp4 EXIT /b 0

ECHO "Path src : %pathSrc%"

IF EXIST "%filePathDst%" (
  ECHO "File already exist. Skipping..."
  EXIT /b 0
)

IF NOT EXIST "%pathDst%" mkdir "%pathDst%"

ECHO "Transcoding..."

"C:\Users\Franck\.telmi\bin\ffmpeg.exe" -y -i "%pathSrc%" -vf scale=1280:-1 -c:v libx265 -b:v 1500k -x265-params pass=1:no-slow-firstpass=1 -an -f null NUL && ^
"C:\Users\Franck\.telmi\bin\ffmpeg.exe" -i "%pathSrc%" -vf scale=1280:-1 -c:v libx265 -b:v 1500k -x265-params pass=2 -c:a copy "%filePathDst%"

IF EXIST "x265_2pass.log" DEL "x265_2pass.log"
IF EXIST "x265_2pass.log.cutree" DEL "x265_2pass.log.cutree"

EXIT /b 0