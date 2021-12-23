@echo off

SET username=%1
SET repoDir=%2
SET apacheVersion=%3
SET repoClonePath=%4
SET wamppPath=%5

SET vhostLine3=	ServerName %username%.smartwebsitedesign.loc
SET vhostLine4=	DocumentRoot "%repoClonePath%/%repoDir%/www"
SET vhostLine6=		Options +Indexes +Includes +FollowSymLinks +MultiViews
SET vhostLine7=		AllowOverride All
SET vhostLine8=		Require local

echo.>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo #>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo ^<VirtualHost *:80^>>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo %vhostLine3%>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo %vhostLine4%>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo 	^<Directory "%repoClonePath%/%repoDir%/www"^>>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo %vhostLine6%>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo %vhostLine7%>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo %vhostLine8%>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo 	^</Directory^>>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf
echo ^</VirtualHost^>>>%wamppPath%\bin\apache\%apacheVersion%\conf\extra\httpd-vhosts.conf

SET hostLine1=127.0.0.1	%username%.smartwebsitedesign.loc
SET hostLine2=::1	%username%.smartwebsitedesign.loc
echo.>>C:\Windows\System32\drivers\etc\hosts
echo %hostLine1%>>C:\Windows\System32\drivers\etc\hosts
echo %hostLine2%>>C:\Windows\System32\drivers\etc\hosts