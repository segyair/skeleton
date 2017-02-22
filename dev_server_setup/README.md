

0. in aws console - in instance's security group, add rule <tcp, 9192, Anywhere>



1. copy this whole directory to the new host:

$ scp -i sample.pem -r * ec2-user@<my-server>.compute.amazonaws.com:/home/ec2-user/



2. ssh to the server:

$ ssh -i sample.pem ec2-user@<my-server>.compute.amazonaws.com



3. on the server, execute the following:

[ec2-user@<my-server> ~]$ ./main_ec2.sh


TODO:
1. anikan.sh - try to drop these two lines:
     sudo yum install ruby-devel -y
     gem install io-console

2. chage folders structure, and make the workaround when creating the rpm
   (e.g. don't use this structure: /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/current,
   only use: /home/anikan/dev/tutorial/greeter/code).




