"use strict"

var swig = require('swig');

module.exports = {

	renderer: function( request , reply , template){

		console.log( "Renderer request : " , template );
		return swig.renderFile( template , {
			parameters : 'no'
		} );
	}
	 
};