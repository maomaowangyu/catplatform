<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="area.add" /></title>

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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/office/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/office/list.do"/>');
        }
    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="office.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="office"  method="post" class="cmxform form-horizontal adminex-form">
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext" ><spring:message code="area.top" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="office" name="parent.id" value="${office.parent.id}"
                                                labelName="parent.name" labelValue="${office.parent.name}"
                                                title="机构" url='/office/treeData.do' extId="${office.id}" cssClass="required" cssStyle="height: 34px;padding: 6px 12px; font-size: 14px;line-height: 1.42857143;color: #555;background-color: #fff;background-image: none; border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);box-shadow: inset 0 1px 1px rgba(0,0,0,.075);font-family:'微软雅黑'" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext" ><spring:message code="area.top" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="area" name="area.id" value="${office.area.id}"
                                                labelName="area.name" labelValue="${office.area.name}"
                                                title="地区" url='/area/treeData.do'  cssClass="required selectcss" />
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
                                <form:input path="code" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="type" />:</label>
                            <div class="col-lg-6">
                                <form:select path="type" class="selectcss" cssErrorClass="error" >
                                    <form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="leave" />:</label>
                            <div class="col-lg-6">
                                <form:select path="grade" class="selectcss" cssErrorClass="error" >
                                    <form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="leave" />:</label>
                            <div class="col-lg-6">
                                <form:select path="useable" class="selectcss" cssErrorClass="error">
                                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                                <span class="help-inline">“是”代表此账号允许登陆，“否”则表示此账号不允许登陆</span>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.vippersion" />:</label>
                            <div class="col-lg-6">
                                <sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}"
                                                title="用户" url="/office/treeData.do?type=3" allowClear="true" notAllowSelectParent="true" cssClass="selectcss"

                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.persion" />:</label>
                            <div class="col-lg-6">
                                <sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name" labelValue="${office.deputyPerson.name}"
                                                title="用户" url="/office/treeData.do?type=3" allowClear="true" notAllowSelectParent="true"
                                                cssStyle="height: 34px;padding: 6px 12px; font-size: 14px;line-height: 1.42857143;color: #555;background-color: #fff;background-image: none; border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);box-shadow: inset 0 1px 1px rgba(0,0,0,.075);font-family:'微软雅黑'"
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.address" />:</label>
                            <div class="col-lg-6">
                                <form:input path="address" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.zipCode" />:</label>
                            <div class="col-lg-6">
                                <form:input path="zipCode" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.master" />:</label>
                            <div class="col-lg-6">
                                <form:input path="master" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.phone" />:</label>
                            <div class="col-lg-6">
                                <form:input path="phone" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.fax" />:</label>
                            <div class="col-lg-6">
                                <form:input path="fax" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office.email" />:</label>
                            <div class="col-lg-6">
                                <form:input path="email" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" maxlength="50"/>

                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" cssClass="required  form-control"  cssErrorClass="error" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:office:edit">
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
