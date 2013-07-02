package com.testapp

class InvoiceItem {
String name
static belongsTo = [invoice:Invoice]
    static constraints = {
		name()
    }
}
