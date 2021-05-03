# Setup an "ssh" ubuntu image on [ Akash ](https://akash.network)  

## Optional : build custom Docker image (recommended)
Update Dockerfile with your needs.
```
# Note you can also use the prebuilt image at user994455/ubuntu-base:0.2
$ docker build -t $your_dockerhub_user/ubuntu-base:0.2 .
```
Update deply.yml with your newly built docker image. ( or keep the prebuilt image)
## Buy me a coffee to keep the work going

| | |
--- | --- 
|akash:|`akash1k07dv0wcjej4e4a5z9dg3c6yvvf9mcnz0sacp9`|
|monero:| `88z2xaJaRPVc5VXtE3CArxeAkqSQV8aA4EhswR8pqfY3CghQfaD7nYsLvmcnXuHj1TYDeJaGvyyyW9XyX6ka7BLzQ7ypmqJ`|

## Prepare your ssh session

On your workstation setup an ssh public/private key pair.
```
$ssh-keygen -t rsa
# (a password is optional. But in most cases you don't need one).
# Note that $HOME/.ssh/id_rsa.pub is now created
```

## Update deploy.yml

Copy and paste the contents of `$HOME/.ssh/id_rsa.pub` and paste them into deploy.yml (env -> pubkey). (deploy.yml : line 8). 

### Update resources as needed. Set the amount of RAM / CPU / diskspace as needed.

## Deploy to Akash
* This assumes that you have installed akash in `$HOME/bin/akash`
* Read through https://github.com/tombeynon/akash-deploy. Thanks for the excellent guide!
* Broadly speaking you will need to:

###  Create an akash address 
``` 
make address
echo "export AKASH_ADDRESS=**address** " >> env.sh
``` 

** Fund `AKASH_ADDRESS` with at least 5 AKT
** create a deployment (you can use deploy.yml) as an example
```
# Need to do this once
make create_certificate
```
```
make create_deployment
make list_bid
```
### accept a bid
```
make create_lease PROVIDER=**provider** DSEQ=**dseq**
```
### push the manifest
```
make send_manifest PROVIDER=**provider** DSEQ=**dseq**
```
### Read logs
```
make lease_logs PROVIDER=**provider** DSEQ=**dseq**
```

## Most importantly -- how do you interact with this?

```
make lease_status PROVIDER=**provider** DSEQ=**dseq**
```

Take a note of the URL and exposed random port. That is your ssh port to access.

```
ssh -p $RANDOMPORT root@URL
```

### Debug

If things are still not working you can set "debug=true" in the environment variables. This will cause sssd to run with debug mode to get additional info. As a side effect as soon as you close your session it will kill the SSH session.
