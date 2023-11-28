if not exist C:\etc\log mkdir C:\etc\log

set TEST_RUN_LOG=C:\etc\log\test_run_%date:~0,7%.log
echo %TEST_RUN_LOG%

echo ====================================================================== >> %TEST_RUN_LOG%
echo %date%, %Time% >> %TEST_RUN_LOG%

set TESTIMG=%1
set ISSUE=%2
set ASSIGNER=%3
set REVISION=%4
set Agent=%5
set dkns=%6
set dknsprivateIP=%7

set "url=https://genian-dev-autotest.s3.ap-northeast-2.amazonaws.com/revision/%REVISION%.zip"
set "outputFile=C:\%REVISION%.zip"

powershell -Command "& { Invoke-WebRequest '%url%' -OutFile '%outputFile%' }"
powershell expand-archive -Force C:\%REVISION%.zip" c:\CLOUD

cd /d C:\CLOUD\home\release\bamboo-agent-home\xml-data\build-dir\CI2NAC-CN6-AUTOTEST\test\v6 && cmd /k "mvn compile && mvn exec:java -Dexec.mainClass=com.genians.TestRun -Dexec.args="%TESTIMG% %ISSUE% %ASSIGNER% %REVISION% %Agent% %dkns% %dknsprivateIP%" >> %TEST_RUN_LOG%"
