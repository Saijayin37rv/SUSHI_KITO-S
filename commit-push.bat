@echo off
setlocal EnableExtensions
cd /d "%~dp0"

echo.
echo === SUSHI KITO'S: commit y push ===
echo.

git status --short
echo.

git add -A
git diff --cached --quiet
if errorlevel 1 goto do_commit

echo No hay cambios nuevos. Se sube lo que ya este en commits locales.
goto do_push

:do_commit
set "MSG="
set /p MSG=Mensaje del commit: 
if "%MSG%"=="" (
  echo Escribe un mensaje para poder continuar.
  goto do_commit
)

git commit -m "%MSG%"
if errorlevel 1 (
  echo.
  echo El commit no se completo.
  pause
  exit /b 1
)

:do_push
echo.
git push
if errorlevel 1 (
  echo.
  echo El push no se completo. Revisa la sesion de GitHub.
  pause
  exit /b 1
)

echo.
echo Listo: cambios subidos.
pause
exit /b 0
