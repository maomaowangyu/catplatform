<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	 <meta charset="utf-8">
	<title>编辑</title>
	    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					save();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});

		function save() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/abc/testTree/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/abc/testTree/list.do"/>');
        }
	</script>
</head>
<body>
	<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                新增
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="testTree"  method="post" class="cmxform form-horizontal adminex-form">
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">上级父级编号:</label>
                <div class="col-lg-5">
                    <sys:treeselect id="parent" name="parent.id" value="${testTree.parent.id}" labelName="parent.name" labelValue="${testTree.parent.name}"
                                    title="父级编号" url="/abc/testTree/treeData.do" extId="${testTree.id}" cssClass="selectcss" allowClear="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">所有父级编号：</label>
                <div class="col-lg-5">
                        <form:input path="parentIds" htmlEscape="false" maxlength="2000" class="form-control required"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">名称：</label>
                <div class="col-lg-5">
                        <form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">排序：</label>
                <div class="col-lg-5">
                        <form:input path="sort" htmlEscape="false" maxlength="10" class="form-control required digits"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">备注信息：</label>
                <div class="col-lg-5">
                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
                </div>
            </div>

                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="abc:testTree:edit">
                                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="save" />"/>
                                    &nbsp;
                                    </shiro:hasPermission>
                                <button class="btn btn-default" type="button" onclick="back();"><spring:message code="back" /></button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>