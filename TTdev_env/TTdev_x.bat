@echo off

:: ========================================================================
:: SPDX-FileCopyrightText: 2022-2025 Harald Pretl and Georg Zachl
:: ... (Licencia omitida por brevedad) ...
:: SPDX-License-Identifier: Apache-2.0
:: ========================================================================
::
:: SCRIPT MODIFICADO para ejecutar la imagen local 'analogdev:1.0'
::
SETLOCAL

SET DEFAULT_DESIGNS=%USERPROFILE%\ttdev\designs

IF DEFINED DRY_RUN (
  echo This is a dry run, all commands will be printed to the shell ^(Commands printed but not executed are marked with ^$^)!
  SET ECHO_IF_DRY_RUN=ECHO $
)

IF "%DESIGNS%"=="" (
  SET DESIGNS=%DEFAULT_DESIGNS%
)
echo Using/creating designs directory: %DESIGNS%
if not exist "%DESIGNS%" %ECHO_IF_DRY_RUN% mkdir "%DESIGNS%" 


SET MY_IMAGE_NAME=ttdev:1.0
SET CONTAINER_NAME=ttdev_xserver


IF "%DISP%"=="" SET DISP=:0
IF "%WAYLAND_DISP%"=="" SET WAYLAND_DISP=wayland-0

IF "%JUPYTER_PORT%"=="" (
  SET JUPYTER_PORT=8888
)

SET PARAMS=

IF %JUPYTER_PORT% GTR 0 (
  SET PARAMS=%PARAMS% -p %JUPYTER_PORT%:8888
)

IF DEFINED DOCKER_EXTRA_PARAMS (
  SET PARAMS=%PARAMS% %DOCKER_EXTRA_PARAMS%
)


docker container inspect %CONTAINER_NAME% 2>&1 | find "Status" | find /i "running" >nul
IF NOT ERRORLEVEL 1 (
    echo Container is running! Stop with "docker stop %CONTAINER_NAME%" and remove with "docker rm %CONTAINER_NAME%" if required.
) ELSE (
    docker container inspect %CONTAINER_NAME% 2>&1 | find "Status" | find /i "exited" >nul
    IF NOT ERRORLEVEL 1 (
        echo Container %CONTAINER_NAME% exists. Restart with "docker start %CONTAINER_NAME%" or remove with "docker rm %CONTAINER_NAME%" if required.
    ) ELSE (
        echo Container does not exist, creating %CONTAINER_NAME% from local image %MY_IMAGE_NAME% ...
        %ECHO_IF_DRY_RUN% docker run -d -e DISPLAY=%DISP% -e WAYLAND_DISPLAY=%WAYLAND_DISP% -e XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir -e PULSE_SERVER=/mnt/wslg/PulseServer -v /run/desktop/mnt/host/wslg/.X11-unix:/tmp/.X11-unix -v /run/desktop/mnt/host/wslg:/mnt/wslg --device=/dev/dxg -v /usr/lib/wsl:/usr/lib/wsl %PARAMS% -v "%DESIGNS%":/analogdev/design --name %CONTAINER_NAME% %MY_IMAGE_NAME%
    )
)


