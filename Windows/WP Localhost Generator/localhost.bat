@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo :::::::::::::::::::::::::::::::::::::::::::::::::::
	echo ::                                               ::
	echo ::    Requesting administrative privileges..     ::
	echo ::                                               ::
	echo :::::::::::::::::::::::::::::::::::::::::::::::::::
	echo. 
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "%1 %2", "", "runas", 1 >> "%temp%\getadmin.vbs"
	
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::          Custom Localhost Generator.          ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

D:
cd D:\scripts\config

IF NOT EXIST "localhostConfig" (	
	echo Usage: Missing Config File Unable to Start Program
	pause
	exit 1
)

echo.
echo Fetching Wampp Installation Folder Path...

for /f "tokens=*" %%i in ('FINDSTR /C:"wamppPath" localhostConfig') do SET wamppPathVar=%%i
set semiWamppPath=%wamppPathVar:wamppPath [[ =%
set wamppPath=%semiWamppPath: ]]=%
set wamppPathWithBackSlash=%wamppPath:/=\%

echo.
echo Fetching DB and wp-config Dump Folder Path...

for /f "tokens=*" %%i in ('FINDSTR /C:"dumpPath" localhostConfig') do SET dumpPathVar=%%i
set semiDumpPath=%dumpPathVar:dumpPath [[ =%
set dumpPath=%semiDumpPath: ]]=%
set dumpPathWithBackSlash=%dumpPath:/=\%

echo.
echo Fetching Repo cloning DIR Path...

for /f "tokens=*" %%i in ('FINDSTR /C:"repoClonePath" localhostConfig') do SET repoClonePathVar=%%i
set semiRepoClonePath=%repoClonePathVar:repoClonePath [[ =%
set repoClonePath=%semiRepoClonePath: ]]=%
set repoClonePathWithBackSlash=%repoClonePath:/=\%

echo.
echo Fetching Apache Version...

for /f "tokens=*" %%i in ('FINDSTR /C:"apacheVersion" localhostConfig') do SET apacheVersionVar=%%i
set semiApacheVersion=%apacheVersionVar:apacheVersion [[ =%
set apacheVersion=%semiApacheVersion: ]]=%

echo.
echo Fetching Apache Version...

for /f "tokens=*" %%i in ('FINDSTR /C:"mySQLVersion" localhostConfig') do SET mySQLVersionVar=%%i
set semiMySQLVersion=%mySQLVersionVar:mySQLVersion [[ =%
set mySQLVersion=%semiMySQLVersion: ]]=%

SET argCount=1
SET reqArgCount=2
for %%i in (%*) do SET /A argCount+=1

if %argCount% LSS %reqArgCount% (
	echo Usage: filename.bat username gitURL databaseName
	pause
	exit 1
)


echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::               Initializing Setup              ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

SET username=%1
SET gitURL=%2
SET domainName=%username%.smartwebsitedesign.com
SET repoDir=%gitURL:~31%
SET localURL=%username%.smartwebsitedesign.loc

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::             Making Dump Directory             ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
mkdir %dumpPathWithBackSlash%\%username%

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::                 Starting WAMPP                ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
D:
cd %wamppPathWithBackSlash%
START "" wampmanager.exe

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::                Cloning repo...                ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
cd %repoClonePath%
git clone %gitURL% %repoDir%

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::         Downloading wp-config file...         ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
scp -P 9000 %username%@%domainName%:/home/%username%/repo/www/wp-config.php %dumpPath%/%username%

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::        Setting up config for localhost        ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
D:
cd %dumpPath%/%username%

for /f "tokens=*" %%i in ('FINDSTR /C:"$table_prefix" wp-config.php') do SET tablePrefix=%%i
set prefix=%tablePrefix: =% 

for /f "tokens=*" %%i in ('FINDSTR /C:"UPLOADS" wp-config.php') do SET uploads=%%i
set UPLOADS=%uploads:,=^,%

for /f "tokens=*" %%i in ('FINDSTR /C:"DB_NAME" wp-config.php') do SET databaseLine=%%i
set databasePartialLine=%databaseLine:define( 'DB_NAME', '=%

set databaseName=%databasePartialLine:' );=%

SET WP_HOME=define('WP_HOME'^,'http://%localURL%');
SET WP_SITEURL=define('WP_SITEURL'^,'http://%localURL%');


echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::            Creating temp folder...            ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
mkdir temp
cd temp

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::         Generating new config file...         ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call wp-config.bat "%databaseName%" "%uploads%" "%WP_HOME%" "%WP_SITEURL%" "%tablePrefix%"

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::      Copying config file to the repo...       ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
xcopy wp-config.php %repoClonePathWithBackSlash%\%repoDir%\www

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::            Removing temp folder...            ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
cd ..
rmdir /s temp

echo.
echo Enter the password of the server to dump the database...
ssh %username%@%domainName% -p 9000 mysqldump -u %username% -p %databaseName%^>%databaseName%.sql

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::            Downloading database...            ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
scp -P 9000 %username%@%domainName%:/home/%username%/%databaseName%.sql %dumpPath%/%username%


echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::             Creating localhost...             ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
call create_localhost.bat %username% %repoDir% %apacheVersion% %repoClonePath% %wamppPathWithBackSlash%

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::             Importing database...             ::
echo ::       Just press enter for password...        ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
D:\wamp64\bin\mysql\%mySQLVersion%\bin\mysql.exe -u root -p -e "SHOW DATABASES; DROP DATABASE IF EXISTS %databaseName%; CREATE DATABASE IF NOT EXISTS %databaseName%; SHOW DATABASES LIKE '%databaseName%'; USE %databaseName%; SOURCE %dumpPath%/%username%/%databaseName%.sql;"

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::    Import Completed. Restarting Apache...     ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

cd %wamppPathWithBackSlash%\bin\apache\%apacheVersion%\bin 
call httpd.exe -k restart -n wampapache64

echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                               ::
echo ::          Localhost Setup Completed.           ::
echo ::                                               ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::
echo.

cd /

echo.
echo   _    _                            _____          _ _             
echo  ^| ^|  ^| ^|                          ^/ ____^|        ^| (_)            
echo  ^| ^|__^| ^| __ _ _ __  _ __  _   _  ^| ^|     ___   __^| ^|_ _ __   __ _ 
echo  ^|  __  ^|^/ _` ^| '_ ^\^| '_ ^\^| ^| ^| ^| ^| ^|    ^/ _ ^\ ^/ _` ^| ^| '_ ^\ ^/ _` ^|
echo  ^| ^|  ^| ^| (_^| ^| ^|_) ^| ^|_) ^| ^|_^| ^| ^| ^|___^| (_) ^| (_^| ^| ^| ^| ^| ^| (_^| ^|
echo  ^|_^|  ^|_^|^\__,_^| .__^/^| .__^/ ^\__, ^|  ^\_____^\___^/ ^\__,_^|_^|_^| ^|_^|^\__, ^|
echo               ^| ^|   ^| ^|     __^/ ^|                             __^/ ^|
echo               ^|_^|   ^|_^|    ^|___^/                             ^|___^/ 

pause