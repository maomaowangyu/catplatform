<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="menu.add" /></title>

    <script type="text/javascript">
                $(document).ready(function() {
                    $("#name").focus();


                    $("#inputForm").validate({
                        submitHandler: function(form){
                           // form.submit();
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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/menu/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/menu/list.do"/>');
        }
    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="menu.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
<form:form id="inputForm" modelAttribute="menu"  method="post" class="cmxform form-horizontal adminex-form">
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext" ><spring:message code="menu.top" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
                                                title="菜单" url='/menu/treeData.do' extId="${menu.id}" cssClass="required selectcss"  />
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="name" />:</label>
                            <div class="col-lg-6">
                                <form:input path="name" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50" />
                            </div>
                            <div class="col-lg-1">
                                <span class="help-inline"><font color="red">*</font> </span>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="sname" />:</label>
                            <div class="col-lg-6">
                                <form:input path="sname" cssClass="form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50" />
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="href" />:</label>
                            <div class="col-lg-6">
                                <form:input path="href" htmlEscape="false" maxlength="2000" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.target" />:</label>
                            <div class="col-lg-6">
                                <form:input path="target" htmlEscape="false" maxlength="10" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.icon" />:</label>
                            <div class="col-lg-6">
                                <sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.sort" />:</label>
                            <div class="col-lg-6">
                                <form:input path="sort" htmlEscape="false" maxlength="50" class="required digits form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.isShow" />:</label>
                            <div class="col-lg-6">
                                <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.leaf" />:</label>
                            <div class="col-lg-6">
                                   <form:radiobuttons path="leaf" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                            </div>
                        </div>
    <div class="form-group ">
        <label class="control-label col-lg-2 ftext"><spring:message code="menu.external_links" />:</label>
        <div class="col-lg-6">
            <form:radiobuttons path="externalLinks" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
        </div>
    </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.permission" />:</label>
                            <div class="col-lg-6">
                                <form:input path="permission" htmlEscape="false" maxlength="100" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="menu.remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:menu:edit">
                                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="save" />"/>
                                    &nbsp;</shiro:hasPermission>
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
