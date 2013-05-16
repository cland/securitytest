package com.testapp
import grails.plugins.springsecurity.Secured
class SecureController {

	@Secured(['ROLE_ADMIN'])
    def index() {
		if (isLoggedIn()) {
			String username = getPrincipal().username
			render 'LOGGED IN: YES: Welcome ' + username
		}else{
			redirect(controller:"Login")
			return false;
		}
	 
		
	}
}
