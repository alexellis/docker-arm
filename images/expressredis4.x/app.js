var express = require ('express');
var app = express();
var redis = require('redis');

app.get('/', function(req,res) {
    var client = redis.createClient(process.env.REDIS_PORT_6379_TCP_PORT,
				    process.env.REDIS_PORT_6379_TCP_ADDR);

    client.incr("hit_count", function() {
        client.get("hit_count", function(err, data) {
            res.json({"message" : "Ping", "count": data});
	          client.quit();
        });
    });
});

var server = app.listen(3000, function() {
    var host = server.address().address;
    var port = server.address().port;

    console.log("http://"+host+ ":" + port);
});
