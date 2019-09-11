#!/bin/bash

export BOOTSTRAP_PORT=80;

## Reading the flags coming in input
## And if the flags are "--port" or/and "--server-id" or/and "--disable-logs", then storing env variables accordingly
while [ ! $# -eq 0 ]
do
  case "$1" in
    --port)
      export BOOTSTRAP_PORT=$2;
      shift 2;
      ;;
    --server-id)
      export BOOTSTRAP_SERVER_ID=$2;
      shift 2;
      ;;
    --disable-logs)
      export BOOTSTRAP_DISABLE_LOGS=true;
      shift 1;
      ;;
    --background-process)
      export BOOTSTRAP_BG_PROCESS=true;
      shift 1;
      ;;
    *)
      echo "\033[33m Wrong argument i.e. $1, found! \033[0m\n";
      echo "Executing with default parameters i.e. port 80 and random server-id\n";
      ;;
  esac
done

if [[ $(lsof -t -i:$BOOTSTRAP_PORT) ]]; then
  echo "!!!!!!!!!!!! Already a process is running on port:  $BOOTSTRAP_PORT !!!!!!!!!!";
  echo "------- Free the port: $BOOTSTRAP_PORT and restart this script ---------";
  exit -1;
fi

## Install the required softwares ##
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install node -y
sudo apt-get install npm -y

## Setup the project directory, files and respective nodejs dependencies ##
cd ~/
mkdir -p bootstrap_server
cd bootstrap_server
touch app.js
npm init -y
npm install --save express morgan

## Writing the basic server side code which will run on the specified port or port 80 ##
cat << EOF > app.js
const express = require("express");
const morgan = require("morgan");

let server_id = process.env.BOOTSTRAP_SERVER_ID;
if (server_id == 0)
  server_id = Math.floor(Math.random()*100);

const app = express();
const port = process.env.BOOTSTRAP_PORT || 80;

if (!process.env.BOOTSTRAP_DISABLE_LOGS)
  app.use(morgan("dev"));
app.disable('etag');

app.get("/favicon.ico", (req, res) => res.status(200));

app.get("/", (req, res) => res.status(200).json({success: true, message: "Health-check is running fine on server number: " + server_id}));

app.listen(port, () => console.log("Server running successfully on port number: " + port + " ..."));
EOF

## Running the server side code
PID=$!;
if [ $BOOTSTRAP_BG_PROCESS = true ]; then
  node app.js &
  sleep 2
  kill $PID
else
  node app.js
fi
