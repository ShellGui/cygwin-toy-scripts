:again
.\mosquitto_pub.exe -h 127.0.0.1 -p 1883 -t "channel" -m "content"
@ping 127.0.0.1 -n 5 -w 1000 > nul
goto again