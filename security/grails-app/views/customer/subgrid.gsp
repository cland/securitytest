
<%@ page import="com.testapp.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
<link rel="stylesheet" href="${resource(dir:'css',file:'ui.jqgrid.css')}" />
<link rel="stylesheet" href="${resource(dir:'css/redmond',file:'jquery-ui-1.9.1.custom.min.css')}" />
<g:javascript library="jquerymin"/>
<g:javascript library="jqueryuilatest"/>
<g:javascript library="jquerygridlocale"/>
<g:javascript library="jquerygrid"/>




	</head>
	<body>
		<a href="#list-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id='message' class="message" style="display:none;"></div>

<div style="margin-top:5px">
  <input class="ui-corner-all" id="btnAdd" type="button" value="Add Record"/>
  <!--  input class="ui-corner-all" id="btnEdit" type="button" value="Edit Selected Record"/ -->
  <input class="ui-corner-all" id="btnDelete" type="button" value="Delete Selected Record"/>
</div>		
		<!-- table tag will hold our grid -->
<table id="customer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="customer_list_pager" class="scroll" style="text-align:center;"></div>

<script type="text/javascript">// <![CDATA[
  /* when the page has finished loading.. execute the follow */
  $(document).ready(function () {
	// set on click events for non toolbar buttons
      $("#btnAdd").click(function(){
        $("#customer_list").jqGrid("editGridRow",
                "new",
                {addCaption:'Create New Customer', afterSubmit:afterSubmitEvent,savekey:[true,13]}
        );
        
      });

      $("#btnEdit").click(function(){
         var gr = $("#customer_list").jqGrid('getGridParam','selrow');
         if( gr != null )
           $("#customer_list").jqGrid('editGridRow',gr,
           {closeAfterEdit:true,
            afterSubmit:afterSubmitEvent
           });
         else
           alert("Please Select Row");
      });

      $("#btnDelete").click(function(){
          deleteRow(null); //delete the selected row         
      });

      //initialize the grid
      centerForm = function ($form) {
                    $form.closest('div.ui-jqdialog').position({
                        my: "center",
                        of: grid.closest('div.ui-jqgrid')
                    });
                };
                
    jQuery("#customer_list").jqGrid({
      url:'jq_customer_list',
      editurl:'jq_edit_customer',
      width:850,
      height:"100%",
      datatype: "json",
      colNames:['First Name','Last Name','Age','Email Address','id','Actions'],
      colModel:[
        {name:'firstName', editable:true,editrules:{required:true}},
        {name:'lastName', editable:true,editrules:{required:true}},
        {name:'age', editable:true,editoptions:{size:3},editrules:{required:true,integer:true},edittype:"select",formatter:'select', editoptions:{value:"20:20;30:30;35:35;40:40"}},
        {name:'emailAddress', editable:true,editoptions:{size:30},editrules:{required:true,email:true}},
        {name:'id',hidden:true},
        {name:'act',index:'act', width:160,sortable:false,search:false}
     ],
     rowNum:2,
     rowList:[1,2,3,4],
     multiselect: false,
    pager: jQuery('#customer_list_pager'),
    viewrecords: true,
    gridview: true,
    cellEdit:true,
    cellsubmit: 'remote',
   	cellurl:'jq_edit_customer',
   subGridRowExpanded: function(subgrid_id,row_id){
	   //subgrid_id: id of the div tag created within table data
	   //id of this element is combination of the "sg_" + id of the row
	   var subgrid_table_id, pager_id;
	   subgrid_table_id = subgrid_id + "_t";
	   pager_id = "p_" + subgrid_table_id;
	   console.log(subgrid_table_id + " - " + pager_id);
	   
	   $("#"+subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
	   jQuery("#"+subgrid_table_id).jqGrid({
		   url:"jq_invoice_list",
		   editurl:'jq_edit_invoice',
		   datatype:"json",
		   colNames:['Invoice Number','Amount','<input type="button" name="Add_Invoice" onClick="addRow(\''+row_id+'\',\''+subgrid_table_id+'\');" id="inv_add" value="Add Invoice"/>','Customer Id'],
		   colModel:[ {name:'invoiceNo', editable:true,width:100,editrules:{required:true},align:'right'},
		              {name:'amount', editable:true,width:100,editrules:{required:true},align:'left'},{sortable:false},
		              {name:'custid',index:'custid',editable:true, width:160,sortable:false,search:false,editoptions:{defaultValue:row_id}}],
		   //rowNum:2,
		   pager:pager_id,
		   sortname:'invoiceNo',
		   sortorder:'asc',
		   height:"100%",
		   width:400,		   
		   cellEdit:true,
		    cellsubmit: 'remote',
		   	cellurl:'jq_edit_invoice',
		   postData:{id:row_id}           
		   });
	  // jQuery("#"+subgrid_table_id).setGridParam({id:row_id})
	   jQuery("#"+subgrid_table_id).jqGrid('navGrid'),"#"+pager_id,{edit:false,add:false,del:false}
	   },
	subGridRowColapsed: function(subgrid_id,row_id){
		//This functiona is called before removing the data
		//var subgrid_table_id;
		//subgrid_table_id = subgrid_id+"_t";
		//jQuery("#"+subgrid_table_id).remove();
		},   
    subGrid : true,
    //subGridUrl : 'jq_invoice_list',
    //subGridModel: [{name:['Inv Number','Amount'],width:[100,100]}],
    gridComplete: function(){ 
        var ids = jQuery("#customer_list").jqGrid('getDataIDs'); 
        
        for(var i=0;i < ids.length;i++)
            { 
            	var cl = ids[i]; 
	            be = "<input style='height:22px;width:42px;' type='button' value='Edit' onclick=\"jQuery('#customer_list').editRow('"+cl+"');\" />"; 
	            se = "<input style='height:22px;width:42px;' type='button' value='Save' onclick=\"jQuery('#customer_list').saveRow('"+cl+"');\" />"; 
	            ce = "<input style='height:22px;width:42px;' type='button' value='Cancel' onclick=\"jQuery('#customer_list').restoreRow('"+cl+"');clearSelection();\" />"; 
	            de = "<input style='height:22px;width:82px;' type='button' value='Delete' onclick=\"deleteRow('"+cl+"');\" />";
	            ad = "<input style='height:22px;width:82px;' type='button' value='Add Invoice' onclick=\"addRow('"+cl+"');\" />";
	            jQuery("#customer_list").jqGrid('setRowData',ids[i],{act:ad+de}); //be+se+ce+de forall actions 
            }
    } 
    }).navGrid('#customer_list_pager',
            {add:false,edit:false,del:false,search:false,refresh:true}, // which buttons to show?
            {closeAfterEdit:true, afterSubmit:afterSubmitEvent,savekey:[true,13],afterShowForm: centerForm},  // edit options
            {addCaption:'Create New Customer',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterEdit:false},  // add options            
           {afterShowForm: centerForm}          // delete options
        );
    $("#customer_list").jqGrid('filterToolbar',{autosearch:true});
   
  });  
// ]]>
  function afterSubmitEvent(response, postdata) {
      var success = true;
  
      var json = eval('(' + response.responseText + ')');
      var message = json.message;

      if(json.state == 'FAIL') {
          success = false;
      } else {
        $('#message').html(message);
        $('#message').show().fadeOut(10000);
      }
      
      var new_id = json.id
      return [success,message,new_id];
  }
  function deleteRow(id){	  
	  if (id!= null) jQuery('#customer_list').jqGrid('setSelection',id);
	  var gr = $("#customer_list").jqGrid('getGridParam','selrow'); //if multi use: 'selarrrow'
      
      if( gr != null && gr != "" )
        $("#customer_list").jqGrid('delGridRow',gr , {afterSubmit:afterSubmitEvent});
      else
        alert("Please Select Row to delete!");
  }
  function addRow(row_id, subgrid_id){
	 grid = $("#" + subgrid_id)
	 //grid.setGridParam({ postData: { id: row_id} });
	 grid.jqGrid("editGridRow",
              "new",
              {addCaption:'Create New Invoice', afterSubmit:afterSubmitEvent,savekey:[true,13]}
      );
	}
  function clearSelection(){jQuery('#customer_list').jqGrid('resetSelection'); }
</script>
	</body>
</html>
