@echo off
setlocal

set "DEPLOYED_JAR=deployment\test\proyecto-ci-cd.jar"

echo ========================================
echo PRUEBA DE ACEPTACION DEL DESPLIEGUE
echo ========================================

if not exist "%DEPLOYED_JAR%" (
    echo ERROR: El JAR no existe en el entorno de prueba.
    exit /b 1
)

echo JAR encontrado correctamente:
echo %DEPLOYED_JAR%

echo.
echo Prueba de aceptacion del despliegue: OK

endlocal