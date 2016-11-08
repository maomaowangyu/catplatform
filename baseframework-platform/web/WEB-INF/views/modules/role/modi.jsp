<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="role.modi" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#name").focus();


            $("#inputForm").validate({

                rules: {
                    name: {remote: "<c:url value="${fns:getAdminPath()}/role/checkName.do"/>?oldName=" + ("${role.name}")},
                    enname: {remote: "<c:url value="${fns:getAdminPath()}/role/checkEnname.do"/>?oldEnname=" + encodeURIComponent("${role.enname}")}
                },
                messages: {
                    name: {remote: "角色名已存在"},
                    enname: {remote: "英文名已存在"}
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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/role/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/role/list.do"/>');
        }


    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="role.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="role"  method="post" class="cmxform form-horizontal adminex-form">
                        <form:hidden path="id"/>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="office" />:</label>
                            <div class="col-lg-9">
                                <sys:treeselect id="office" name="office.id" value="${role.office.id}" labelName="office.name" labelValue="${role.office.name}"
                                                title="机构" url="/office/treeData.do" cssClass="required selectcss"   />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role.name" />:</label>
                            <div class="col-lg-5">
                                <input id="oldName" name="oldName" type="hidden" value="${role.name}">
                                <form:input path="name" htmlEscape="false"  cssErrorClass="error"  maxlength="50"  cssClass="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role.ename" />:</label>
                            <div class="col-lg-5">
                                <input id="oldEnname" name="oldEnname" type="hidden" value="${role.enname}">
                                <form:input path="enname" htmlEscape="false"  cssErrorClass="error"   maxlength="50"  minlength="5" ise="true"  cssClass="required  form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role.type" />:</label>
                            <div class="col-lg-5">
                                <form:select path="roleType" class="selectcss">
                                    <form:option value="assignment">任务分配</form:option>
                                    <form:option value="security-role">管理角色</form:option>
                                    <form:option value="user">普通角色</form:option>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="role.sys" />:</label>
                            <div class="col-lg-5">
                                <form:select path="sysData" class="selectcss">
                                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="useable" />:</label>
                            <div class="col-lg-5">
                                <form:select path="useable" class="selectcss">
                                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                                <span class="help-inline">“是”代表此数据可用，“否”则表示此数据不可用</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dataScope" />:</label>
                            <div class="col-lg-5">
                                <form:select path="dataScope" class="selectcss">
                                    <form:options items="${fns:getDictList('sys_data_scope')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="authority" />:</label>
                            <div class="col-lg-6">
                                <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
                                <form:hidden path="menuIds"/>
                                <div id="officeTree" class="ztree" style="margin-left:100px;margin-top:3px;float:left;"></div>
                                <form:hidden path="officeIds"/>
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
                                <shiro:hasPermission name="sys:role:edit">
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
