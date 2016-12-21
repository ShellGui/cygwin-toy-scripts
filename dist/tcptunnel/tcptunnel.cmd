@REM @Author: anchen
@REM @Date:   2016-08-27 16:37:48
@REM @Last Modified by:   anchen
@REM Modified time: 2016-08-27 16:43:26

@REM 将本机被访问的1080端口,发送到远程的1180端口(测试使用:127.0.0.1)

.\tcptunnel.exe --local-port=1080 --remote-port=1180 --remote-host=127.0.0.1 --buffer-size=8192 --stay-alive

pause
