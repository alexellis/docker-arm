var request = require('request');

var swarmUri = process.env.SWARM_URI;
var labelFilter = process.env.LABEL_FILTER;

// Query the Docker Remote API directly.
var ops = {
 uri: "http://"+warmUri+"/containers/json?all=0&size=1",
 method: "GET"
};

var filter = {"label": [labelFilter]};
ops.uri = ops.uri +"&filters="+ JSON.stringify(filter);

request(ops, function(err, res, body) {
    if(err) {
        return console.error(err);
    }
    // Print to stdout so we can pipe into nginx.conf
    var containers = JSON.parse(body);
    containers.forEach(function(host) {
        console.log("\tserver "+host.Ports[0].IP + ":" + host.Ports[0].PublicPort+ ";");
    });
});
