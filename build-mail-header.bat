@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ===============================================
echo       CER-UFPE :: E-mail Header Builder
echo ===============================================
echo.
echo Insert the following information to build your email header:

set /p FULL_NAME="Full name: "
set /p JOB_TITLE="Job title at CER: "
set /p UFPE_USER_MAIL="UFPE mail user(login): "

echo.
set /p HAS_SECOND_JOB="Do you have a second job location? (y/n): "
if /i "!HAS_SECOND_JOB!"=="y" (
    set /p SECOND_JOB_LOCATION="second job location: "
    set /p SECOND_JOB_TITLE="second job title: "
    set /p SECOND_JOB_ORGANIZATION="second job organization: "
)

echo.
set /p ADD_MOBILE="Do you want to add your mobile number? (y/n): "
if /i "!ADD_MOBILE!"=="y" (
    set /p MOBILE_NUMBER="Mobile number [+55 (xx) xxx xxx xxx]: "
)

echo.
echo -------------------------------------------------
echo FULL NAME: !FULL_NAME!
echo JOB TITLE: !JOB_TITLE!
echo UFPE USER MAIL: !UFPE_USER_MAIL!
if /i "!HAS_SECOND_JOB!"=="y" (
    echo SECOND JOB LOCATION: !SECOND_JOB_LOCATION!
    echo SECOND JOB TITLE: !SECOND_JOB_TITLE!
    echo SECOND JOB ORGANIZATION: !SECOND_JOB_ORGANIZATION!
)
if /i "!ADD_MOBILE!"=="y" (
    echo MOBILE NUMBER: !MOBILE_NUMBER!
)
echo -------------------------------------------------

set /p CONFIRM="Is all the information above correct? (y/n): "
if /i not "!CONFIRM!"=="y" (
    echo Aborted by user.
    exit /b 1
)

rem -------------------------------------------------------
rem MAIL HEADER TEMPLATE

set OUTPUT_FILE=email-header.html

(
echo ^<html^>
echo ^<body style='background-color: black;'^>
echo ^<table cellpadding='0' cellspacing='0' border='0' style='font-family: Arial, sans-serif; background-color: white; box-shadow: 0 2px 8px rgba(0,0,0,0.12^); border-radius: 6px;'^>
echo ^<tr^>
echo     ^<!-- Coluna 1: Imagem à esquerda --^>
echo     ^<td align='center' valign='middle' style='min-width: 240px; min-height: 100px; background: url("https://cer-ufpe.github.io/CER-email-header-left.png"^) no-repeat center center; background-size: auto;'^>
echo     ^</td^>
echo     ^<!-- Coluna 2: Dados de contato --^>
echo     ^<td align='left' bgcolor='white' valign='middle' style='padding: 10px 20px 10px 15px; background-color: white; min-width: 230;'^>
echo     ^<div style='font-size: 16px; margin-bottom: 5px;'^>
echo     ^<strong^>
echo         ^<!--MUDAR: NOME COMPLETO--^>
echo         !FULL_NAME!
echo     ^</strong^>
echo     ^</div^>
echo.
echo     ^<!-- LOTACOES --^>
echo     ^<div style='font-size: 12px; color: #01375b; font-style: italic; font-weight: bold; margin: 10px 0 0 0;'^>
echo         Center for Renewable Energy
echo         ^<span style='font-size: 12px; color: #3c3c3c; font-style: italic; font-weight: bold;'^> ^| !JOB_TITLE!^</span^>
echo     ^</div^>
echo     ^<div style='font-size: 12px; color: #545454; font-style: italic; margin-bottom:5px;'^>
echo         of the Federal University of Pernambuco (CER-UFPE^)
echo     ^</div^>
) > "!OUTPUT_FILE!"

if /i "!HAS_SECOND_JOB!"=="y" (
    (
    echo     ^<div style='font-size: 12px; color: #01375b; font-style: italic; font-weight: bold; margin: 10px 0 0 0;'^>
    echo         !SECOND_JOB_LOCATION!
    echo         ^<span style='font-size: 12px; color: #3c3c3c; font-style: italic; font-weight: bold;'^> ^| !SECOND_JOB_TITLE!^</span^>
    echo     ^</div^>
    echo     ^<div style='font-size: 12px; color: #545454; font-style: italic; margin-bottom:5px;'^>
    echo         of the !SECOND_JOB_ORGANIZATION!
    echo     ^</div^>
    ) >> "!OUTPUT_FILE!"
)

(
echo     ^<!-- CONTATOS --^>
echo     ^<div style='font-size: 11px; margin: 10px 0 2px 0;'^>
echo       ^<img src='https://cer-ufpe.github.io/e-mail-icon.png' height='16px' alt='Email' style='vertical-align: middle;'^>
echo       ^<!--MUDAR: EMAIL--^>
echo       ^<a href='mailto:!UFPE_USER_MAIL!@ufpe.br' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'^>
echo         ^<!--MUDAR: EMAIL--^>
echo         !UFPE_USER_MAIL!@ufpe.br
echo       ^</a^>
echo     ^</div^>
echo     ^<div style='font-size: 11px; margin-bottom: 2px;'^>
echo       ^<img src='https://cer-ufpe.github.io/phone-icon.png' height='15px' alt='Office' style='vertical-align: middle;'^>
echo       ^<!--MUDAR: OFFICE PHONE--^>
echo       ^<a href='tel:+558121267326' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'^>
echo         ^<!--MUDAR: OFFICE PHONE--^>
echo         +55 (81^) 2126-7326
echo       ^</a^>
echo     ^</div^>
) >> "!OUTPUT_FILE!"

if /i "!ADD_MOBILE!"=="y" (
    (
    echo         ^<div style='font-size: 11px; margin-bottom: 2px;'^>
    echo         ^<img src='https://cer-ufpe.github.io/mobile-icon.png' height='15px' alt='Mobile' style='vertical-align: middle;'^>
    echo         ^<a href='tel:!MOBILE_NUMBER!' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'^>
    echo             !MOBILE_NUMBER!
    echo         ^</a^>
    echo         ^</div^>
    ) >> "!OUTPUT_FILE!"
)

(
echo     ^<div style='font-size: 11px; margin-bottom: 2px;'^>
echo       ^<img src='https://cer-ufpe.github.io/web-icon.png' height='16px' alt='Email' style='vertical-align: middle;'^>
echo       ^<a href='https://cer.ufpe.br' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'^>https://cer.ufpe.br^</a^>
echo     ^</div^>
echo     ^</td^>
echo     ^<td style='padding-left: 125px; background: url("https://cer-ufpe.github.io/CER-email-header-right.png"^) no-repeat right bottom;'^>
echo     ^</td^>
echo   ^</tr^>
echo ^</table^>
echo ^</body^>
echo ^</html^>
) >> "!OUTPUT_FILE!"

echo Arquivo HTML criado: !OUTPUT_FILE!
pause
