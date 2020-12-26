require("dotenv").config();
const AWS = require("aws-sdk");
const { NodeSSH } = require("node-ssh");

// ~/.aws/credentials
// [default]
// aws_access_key_id = <YOUR_ACCESS_KEY_ID>
// aws_secret_access_key = <YOUR_SECRET_ACCESS_KEY>

AWS.config.update({region: "ap-northeast-2"});

const ec2 = new AWS.EC2({apiVersion: '2016-11-15'});

const instance = {
  InstanceIds: [
    process.argv[3] || process.env.INSTANCE_ID
  ]
};

const firstArg = process.argv[2];

if (firstArg === "start") {
  ec2.startInstances(instance, (err, data) => {
    if (err) {
      console.log(err);
    } else {
      console.log(data.StartingInstances[0]);
    }
  });
  return;
}

if (firstArg === "stop") {
  console.log(process.argv[4] || process.env.SSH_HOST);
  const ssh = new NodeSSH();
  ssh.connect({
    host: process.argv[3] || process.env.SSH_HOST,
    username: process.env.SSH_USERNAME,
    privateKey: process.env.SSH_PRIVATE,
    readyTimeout: 3000
  }).then(() => {
    ssh.execCommand("./stop.sh");
    console.log("ok");
  }).catch(() => {
    console.log("Instance timed out, probably already stopped");
  });
}

ec2.describeInstances(instance, (err, data) => {
  if (err) {
    console.log(err);
  } else {
    const ec2State = data.Reservations[0].Instances[0].State;
    console.log(ec2State);
    if (!firstArg) {
      console.log("Please run script again with an argument: start, stop");
    }
  }
});
