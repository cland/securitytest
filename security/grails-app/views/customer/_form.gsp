<%@ page import="com.testapp.Customer" %>



<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="customer.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="50" required="" value="${customerInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="customer.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="50" required="" value="${customerInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'age', 'error')} ">
	<label for="age">
		<g:message code="customer.age.label" default="Age" />
		
	</label>
	<g:field name="age" type="number" value="${customerInstance.age}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'emailAddress', 'error')} ">
	<label for="emailAddress">
		<g:message code="customer.emailAddress.label" default="Email Address" />
		
	</label>
	<g:textField name="emailAddress" value="${customerInstance?.emailAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'invoices', 'error')} ">
	<label for="invoices">
		<g:message code="customer.invoices.label" default="Invoices" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${customerInstance?.invoices?}" var="i">
    <li><g:link controller="invoice" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="invoice" action="create" params="['customer.id': customerInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'invoice.label', default: 'Invoice')])}</g:link>
</li>
</ul>

</div>

