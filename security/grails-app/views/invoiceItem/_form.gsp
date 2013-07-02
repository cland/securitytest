<%@ page import="com.testapp.InvoiceItem" %>



<div class="fieldcontain ${hasErrors(bean: invoiceItemInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="invoiceItem.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${invoiceItemInstance?.name}"/>
</div>

