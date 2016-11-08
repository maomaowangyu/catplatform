<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="user.modi" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#no").focus();


            $("#inputForm").validate({

                submitHandler: function (form) {
                    save();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
        function save() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/user/info.do"/>');
        }
    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="user.modi" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="user"  method="post" class="cmxform form-horizontal adminex-form">
                        <form:hidden path="id"/>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.photo" />:</label>
                            <div class="col-lg-5">
                                <form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
                                <sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="company" />:</label>
                            <div class="col-lg-9">
                                    ${user.company.name}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office" />:</label>
                            <div class="col-lg-9">
                                    ${user.office.name}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.no" />:</label>
                            <div class="col-lg-5">
                                    ${user.no}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="name" />:</label>
                            <div class="col-lg-5">
                                    ${user.name}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.loginName" />:</label>
                            <div class="col-lg-5">
                                    ${user.loginName}

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="email" />:</label>
                            <div class="col-lg-5">
                                <form:input path="email"  htmlEscape="false" maxlength="50"  cssErrorClass="error" class="email form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="phone" />:</label>
                            <div class="col-lg-5">
                                <form:input path="phone"  htmlEscape="false" maxlength="50"  cssErrorClass="error" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="mobile" />:</label>
                            <div class="col-lg-5">
                                <form:input path="mobile"  htmlEscape="false" maxlength="50"  cssErrorClass="error" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.type" />:</label>
                            <div class="col-lg-5">
                                    ${fns:getDictLabel(user.userType, 'sys_user_type', '无')}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role" />:</label>
                            <div class="col-lg-5">
                                    ${user.roleNames}
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" cssClass="form-control"  cssErrorClass="error" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                            </div>
                        </div>
                        <c:if test="${not empty user.id}">
                            <div class="form-group ">
                                <label class="control-label col-lg-2 ftext"><spring:message code="createTime" />:</label>
                                <div class="col-lg-6">
                                    <fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/>
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-lg-2 ftext"><spring:message code="ip" />:</label>
                                <div class="col-lg-6">
                                    IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/>                                </div>
                            </div>
                        </c:if>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:user:edit">
                                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="save" />"/>
                                    &nbsp;</shiro:hasPermission>
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
