'use strict';

/*Load dependencies*/
const Hapi = require('hapi');
const path = require('path');

global.__base = path.join( __dirname ,  'src' ) ;
console.log( "__dirname : " + global.__base );

/*Load app config*/
const parameters = require('./src/config/config.js');
const routes = require('./src/config/routes.js');

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({ 
    host: '127.0.0.1', 
    port: 8820 
});

// Add the route
server.route( routes );

// Start the server
server.start((err) => {
    if (err) {
        throw err;
    }
    console.log('Server running at:', server.info.uri);
});
