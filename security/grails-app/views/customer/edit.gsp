<%@ page import="com.testapp.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript library='jquerymin' />
		<script type="text/javascript">
		
		function testSetCookie(){
			alert("set cookie")
			setParams()
			}
		function testGetCookie(){
			var username = getCookie("jock_username")
			 var password = getCookie("jock_password")
			 alert(username + " - " + password)
		}
	
		function getParams() {
			 var username = getCookie("jock_username")
			 var password = getCookie("jock_password")
			 if (username != null && username != "" && password != null
			   && password != "") {
			  $("#username").attr("value", username)

			  $("#password").attr("value", password)

			  $('#remember_me').prop('checked', true);
			 }
			}
			

			function setParams() {
			 
			  setCookie("jock_username", "Jay", 30);
			  setCookie("jock_password", "password", 30);
			 
			}

			function getCookie(c_name) {
			 var c_value = document.cookie;
			 var c_start = c_value.indexOf(" " + c_name + "=");
			 if (c_start == -1) {
			  c_start = c_value.indexOf(c_name + "=");
			 }
			 if (c_start == -1) {
			  c_value = null;
			 } else {
			  c_start = c_value.indexOf("=", c_start) + 1;
			  var c_end = c_value.indexOf(";", c_start);
			  if (c_end == -1) {
			   c_end = c_value.length;
			  }
			  c_value = unescape(c_value.substring(c_start, c_end));
			 }
			 return c_value;
			}

			function setCookie(c_name, value, exdays) {
			 var exdate = new Date();
			 exdate.setDate(exdate.getDate() + exdays);
			 var c_value = escape(value)
			   + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
			 document.cookie = c_name + "=" + c_value;
			}
		</script>
	</head>
	<body>
		<a href="#edit-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<fieldset><legend>TEST COOKIES</legend>
		<input type="button" name="settest" id="settest" value="Set Cookie" onclick="testSetCookie();return false;"/>
		<input type="button" name="gettest" id="gettest" value="get Cookie" onclick="testGetCookie();return false;"/>
		
		
		</fieldset>
		<div id="edit-customer" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${customerInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${customerInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${customerInstance?.id}" />
				<g:hiddenField name="version" value="${customerInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
		<script type="text/javascript">
$(document).ready(function(){
			
			testGetCookie();
	});
		</script>
	</body>
</html>
