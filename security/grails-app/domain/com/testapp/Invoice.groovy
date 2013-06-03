package com.testapp

class Invoice {

    static constraints = {
    }
	static belongsTo = [customer: Customer]
	String invoiceNo
	Double amount
	
	String toString(){
		return "${invoiceNo} - ${amount}"
	}
}
