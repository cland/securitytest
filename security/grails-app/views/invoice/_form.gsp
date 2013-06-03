<%@ page import="com.testapp.Invoice" %>



<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="invoice.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: invoiceInstance, field: 'amount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'customer', 'error')} required">
	<label for="customer">
		<g:message code="invoice.customer.label" default="Customer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="customer" name="customer.id" from="${com.testapp.Customer.list()}" optionKey="id" required="" value="${invoiceInstance?.customer?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: invoiceInstance, field: 'invoiceNo', 'error')} ">
	<label for="invoiceNo">
		<g:message code="invoice.invoiceNo.label" default="Invoice No" />
		
	</label>
	<g:textField name="invoiceNo" value="${invoiceInstance?.invoiceNo}"/>
</div>

