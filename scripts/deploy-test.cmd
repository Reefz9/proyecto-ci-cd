@echo off
setlocal

if "%~1"=="" (
    echo ERROR: Debe indicar el archivo JAR.
    exit /b 1
)

set "JAR=%~1"
set "DEPLOY_DIR=deployment\test"
set "BACKUP_DIR=deployment\backup"
set "DEPLOYED_JAR=%DEPLOY_DIR%\proyecto-ci-cd.jar"
set "BACKUP_JAR=%BACKUP_DIR%\proyecto-ci-cd.jar"

if not exist "%JAR%" (
    echo ERROR: No existe el archivo JAR: %JAR%
    exit /b 1
)

echo ========================================
echo DESPLIEGUE EN ENTORNO DE PRUEBA
echo ========================================

if exist "%DEPLOYED_JAR%" (
    echo Guardando version anterior como respaldo...

    if not exist "%BACKUP_DIR%" (
        mkdir "%BACKUP_DIR%"
    )

    copy /Y "%DEPLOYED_JAR%" "%BACKUP_JAR%"

    if errorlevel 1 (
        echo ERROR: No se pudo crear el respaldo.
        exit /b 1
    )

    echo Respaldo creado correctamente.
)

if exist "%DEPLOY_DIR%" (
    rmdir /s /q "%DEPLOY_DIR%"
)

mkdir "%DEPLOY_DIR%"

copy /Y "%JAR%" "%DEPLOYED_JAR%"

if errorlevel 1 (
    echo ERROR: No se pudo desplegar el JAR.
    exit /b 1
)

echo.
echo Despliegue exitoso en entorno de prueba.
echo Archivo desplegado: %DEPLOYED_JAR%

endlocal