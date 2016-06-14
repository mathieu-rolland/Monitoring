"use strict"

module.exports = function(){

	var env = process.env.NODE_ENV || 'development';
	var appConstants = applicationConfig();

	/***************************************************	
	*
	*	Generate configuration :
	*
	***************************************************/
	var obj = {
		application : {
			url  : appConstants[env]['url'],
			host : appConstants[env]['host'],
			port : appConstants[env]['port'],
		},
		server : {
			defaultHost : 'http://192.168.1.23:10001'
		}
	};

	/***************************************************	
	*
	*	Parameters :
	*
	***************************************************/
	function applicationConfig(){
		return {
			'production' : {
				'url' : 'http://' + process.env.NODE_HOST + ':' + process.env.NODE_PORT ,
				'port' : process.env.NODE_PORT,
				'host' : process.env.NODE_HOST
			},
			'development' : {
				'url' : 'http://' + process.env.NODE_HOST + ':' + process.env.NODE_PORT ,
				'port' : process.env.NODE_PORT,
				'host' : process.env.NODE_HOST
			}
		};
	}

}();