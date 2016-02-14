var request = require('request');
var ops = {
 uri: "http://192.168.0.200:4000/containers/json?all=0&size=1",
 method: "GET"
};
var targetLabel = "node_redis";
var filter = {"label": ["node_redis"]};
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
