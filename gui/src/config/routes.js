"use strict"

const path = require('path');
var templating = require( path.join( global.__base , 'Templating' , 'Templating.js' ) );

module.exports = 
	 [{
		method  : 'GET',
		path    : '/',
		handler : function (request, reply){

			reply( 
					templating.renderer( request , reply , 'src/Views/main.html' ) 
			);

		} 
	}];