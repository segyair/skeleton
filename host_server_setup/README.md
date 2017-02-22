

1. copy this whole directory to the new host:

$ scp -i sample.pem -r * ec2-user@<my-server>.compute.amazonaws.com:/home/ec2-user/



2. ssh to the server:

$ ssh -i sample.pem ec2-user@<my-server>.compute.amazonaws.com



3. on the server, execute the folloeing:

[ec2-user@<my-server> ~]$ ./ec2.sh


4. install the rpm as use anikan:
[ec2-user@<my-server> ~]$ sudo cp greeter-0.0.1-1.x86_64.rpm /home/anikan/

