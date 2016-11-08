<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="user.add" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#no").focus();


            $("#inputForm").validate({

                rules: {
                    loginName: {remote: "<c:url value="${fns:getAdminPath()}/user/checkLoginName.do"/>?oldLoginName=" + ("${user.loginName}")}
                },
                messages: {
                    loginName: {remote: "用户登录名已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },

                submitHandler: function(form){
                    var ids = [], nodes = tree.getCheckedNodes(true);
                    for(var i=0; i<nodes.length; i++) {
                        ids.push(nodes[i].id);
                    }
                    $("#menuIds").val(ids);
                    var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
                    for(var i=0; i<nodes2.length; i++) {
                        ids2.push(nodes2[i].id);
                    }
                    $("#officeIds").val(ids2);
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

            var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
                data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                }}};

            // 用户-菜单
            var zNodes=[
                    <c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
                </c:forEach>];
            // 初始化树结构
            var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
            // 不选择父节点
            tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
            // 默认选择节点
            var ids = "${role.menuIds}".split(",");
            for(var i=0; i<ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                try{tree.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree.expandAll(false);

            // 用户-机构
            var zNodes2=[
                    <c:forEach items="${officeList}" var="office">{id:"${office.id}", pId:"${not empty office.parent?office.parent.id:0}", name:"${office.name}"},
                </c:forEach>];
            // 初始化树结构
            var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
            // 不选择父节点
            tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
            // 默认选择节点
            var ids2 = "${role.officeIds}".split(",");
            for(var i=0; i<ids2.length; i++) {
                var node = tree2.getNodeByParam("id", ids2[i]);
                try{tree2.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree2.expandAll(false);
            // 刷新（显示/隐藏）机构
            refreshOfficeTree();
            $("#dataScope").change(function(){
                refreshOfficeTree();
            });
        });

        function refreshOfficeTree(){
            if($("#dataScope").val()==9){
                $("#officeTree").show();
            }else{
                $("#officeTree").hide();
            }
        }

        function save() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/user/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/user/list.do"/>');
        }


    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="user.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="user"  method="post" class="cmxform form-horizontal adminex-form">


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
                                <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
                                                title="公司" url="/office/treeData.do?type=1" cssClass="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
                                                title="部门" url="/office/treeData.do?type=2" cssClass="required" notAllowSelectParent="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.no" />:</label>
                            <div class="col-lg-5">
                                <form:input path="no" htmlEscape="false" maxlength="50" cssErrorClass="error" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="name" />:</label>
                            <div class="col-lg-5">
                                <form:input path="name" htmlEscape="false" maxlength="50" cssErrorClass="error" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.loginName" />:</label>
                            <div class="col-lg-5">
                                <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
                                <form:input path="loginName" htmlEscape="false" maxlength="50" userName="true" cssErrorClass="error" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.password" />:</label>
                            <div class="col-lg-5">
                                <form:input path="newPassword" type="password" htmlEscape="false" maxlength="50" pas="true" cssErrorClass="error" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.confirmpassword" />:</label>
                            <div class="col-lg-5">
                                <form:input path="confirmNewPassword" type="password" equalTo="#newPassword" htmlEscape="false" maxlength="50"  cssErrorClass="error" class="required form-control"/>
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
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.isstart" />:</label>
                            <div class="col-lg-5">
                                <form:select path="loginFlag"  class="selectcss">
                                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.type" />:</label>
                            <div class="col-lg-5">
                                <form:select path="userType" class="selectcss">
                                    <form:option value="" label="请选择"/>
                                    <form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="user.diglossia" />:</label>
                            <div class="col-lg-5">
                                <form:select path="diglossia"  class="selectcss">
                                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role" />:</label>
                            <div class="col-lg-5">
                                <form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" cssClass="form-control"  cssErrorClass="error" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:user:edit">
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
