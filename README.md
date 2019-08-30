# Server Spinner
Weird name, right?
It would make much more sense if you understand the idea behind it :laughing: :laughing:

----------

## Idea behind it
So, lately I have been playing around a lot with AWS and its uncountable number of services.<br>
And most of the times, while trying out new services, it is required to create a new server, ssh into it, and setup a server side code for it on some port, sometimes for the sake of health-checks, otherwise just for the sake checking out if it sworking or not, from the browser.<br>
So, that thing in itself, generally, involves the following steps :
 - installing nodejs and npm
 - creating a project directory
 - Initializing a node project there
 - Installing some dependencies
 - Writing a basic server side script for running on a port
 - Executing that script

 PS: If you setup the server side code using any other framework like djanog or flask, it will take almost the same number of steps.

<br>
Well, that's TEDIOUS!
<br><br>
So, I decided to write a shell script to automate everything I mentioned above.
And by everything I mean
<br>
<b> On AWS/Azure/GCP/DO, Just pass this shell script as the bootstrap script while setting up compute servers and that's it, you will have a server side code running on that server on a port.</b>

--------------- 

## Use cases:
It can be used to setup a health check API endpoint for your server.

---------------
## How to use it?

Clone/Download this shell script and go to the directory containing this script:

- <b>Default mode - port 80, server-id (random number), Logs enabled, Run as a foreground process</b>
```
bash ./spinup_server.sh --port 8000 --server-id 
```

- <b>On some port, say 8080</b>
```
bash ./spinup_server.sh --port 8080
```

- <b>With a server id, say 65432 - Just in case, if you want to identify different servers in the cloud</b>
```
bash ./spinup_server.sh --server-id 65432
```

- <b>As a background process</b>
```
bash ./spinup_server.sh --background-process
```

- <b>If you want no logs (Calls made to this server) to be printed in the console</b>
```
bash ./spinup_server.sh --disable-logs
```


So, for example,<br>

So, let's say if you want the server side code to run on
 - port 8000   # Default port 80
 - server-id "42"    # Default server id is a random number between 1 and 100
 - Disable API Calls related logs  # Default, logs will be printed in the console/terminal
 - As a background process  # Default, it runs as a foreground server

Then, run the following command
```
bash ./spinup_server.sh --port 8000 --server-id 42 --disable-logs --background-process
```

---------------------------
