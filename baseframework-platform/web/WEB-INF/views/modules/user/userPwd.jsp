<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="user.modi" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#oldPassword").focus();


            $("#inputForm").validate({

                rules: {
                },
                messages: {
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },

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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/user/modifyPwd.do"/>');
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
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.oldpassword" />:</label>
                            <div class="col-lg-5">
                                <input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.password" />:</label>
                            <div class="col-lg-9">
                                <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.confirmpassword" />:</label>
                            <div class="col-lg-9">
                                <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required form-control" equalTo="#newPassword"/>
                            </div>
                        </div>
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
