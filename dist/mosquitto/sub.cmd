:again
.\mosquitto_sub.exe -h 127.0.0.1 -p 1883 -t "channel" -C 1
goto again