:again
.\sshpass -p shellgui  .\ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -N -D 0.0.0.0:1180 root@118.184.39.24
goto again

