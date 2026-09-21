@echo off
setlocal

set "DEPLOY_DIR=deployment\test"
set "BACKUP_DIR=deployment\backup"
set "DEPLOYED_JAR=%DEPLOY_DIR%\proyecto-ci-cd.jar"
set "BACKUP_JAR=%BACKUP_DIR%\proyecto-ci-cd.jar"

echo ========================================
echo ROLLBACK DEL ENTORNO DE PRUEBA
echo ========================================

if not exist "%BACKUP_JAR%" (
    echo ERROR: No existe una version anterior para restaurar.
    exit /b 1
)

if not exist "%DEPLOY_DIR%" (
    mkdir "%DEPLOY_DIR%"
)

copy /Y "%BACKUP_JAR%" "%DEPLOYED_JAR%"

if errorlevel 1 (
    echo ERROR: No se pudo realizar el rollback.
    exit /b 1
)

echo Rollback realizado correctamente.
echo Version anterior restaurada.

endlocal