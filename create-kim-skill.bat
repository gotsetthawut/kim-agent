@echo off
echo Packaging KIM as a Cowork skill...
powershell -Command "Compress-Archive -Path '%~dp0.' -DestinationPath '%~dp0..\kim.skill' -Force"
if exist "%~dp0..\kim.skill" (
    echo.
    echo SUCCESS! kim.skill created at: %~dp0..\kim.skill
    echo.
    echo To install in Cowork: drag kim.skill into any Claude Cowork chat.
) else (
    echo ERROR: Could not create kim.skill
)
pause
