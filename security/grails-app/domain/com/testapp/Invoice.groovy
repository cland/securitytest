package com.testapp

class Invoice {
	static belongsTo = [customer: Customer]
	String invoiceNo
	Double amount
	static hasMany = [items:InvoiceItem]
    static constraints = {
		
    }
	
	String toString(){
		return "${invoiceNo} - ${amount}"
	}
}
