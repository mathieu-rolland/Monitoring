"use strict"

var swig = require('swig');

module.exports = {

	renderer: function( request , reply , template){

		console.log( "Renderer request : " , template );
		return swig.renderFile( template , {
			title : 'Monitoring ' + process.env.HOSTNAME,
			serverName : process.env.HOSTNAME,
			version : '0.0.1'
		} );
	}
	 
};