<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="area.modi" /></title>

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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/area/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/area/list.do"/>');
        }
    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="area.modi" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="area"  method="post" class="cmxform form-horizontal adminex-form">
                        <form:hidden path="id"/>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext" ><spring:message code="area.top" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="area" name="parent.id" value="${area.parent.id}"
                                                labelName="parent.name" labelValue="${area.parent.name}"
                                                title="地区" url='/area/treeData.do' extId="${area.id}" cssClass="required selectcss"  />
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
                            <label class="control-label col-lg-2 ftext"><spring:message code="code" />:</label>
                            <div class="col-lg-6">
                                <form:input path="code" htmlEscape="false" cssClass="form-control"  cssErrorClass="error" maxlength="50"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="type" />:</label>
                            <div class="col-lg-6">
                                <form:select path="type" class="selectcss" cssErrorClass="error" >
                                    <form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="area.remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control" cssErrorClass="error" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:area:edit">
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
