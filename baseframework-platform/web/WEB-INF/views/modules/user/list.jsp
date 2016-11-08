<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="user.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        $("#treeTable").treeTable({expandLevel : 3}).show();
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/user/toAddPage.do"/>');
        }

        function search() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/user/list.do"/>');
        }


        function modi(officeid) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/user/toModiPage.do"/>',officeid)
        }

        function fileexport() {
            ajaxSubmitPostFile('<c:url value="${fns:getAdminPath()}/user/import.do"/>')
        }


        $(document).ready(function() {
            $("#btnExport").click(function(){
                layer.confirm("确认要导出用户数据吗？", {
                    btn: ['确定','取消'] //按钮
                }, function(){
                    $("#searchForm").attr("action","${ctx}/user/export.do");
                    $("#searchForm").submit();
                    layer.closeAll('dialog');
                });
            });
            $("#importBox1").click(function(){
  var uploadText = "<form id=\"importForm1\" name=\"importForm1\"  method=\"post\" enctype=\"multipart/form-data\"  class=\"form-search\" style=\"padding-left:20px;text-align:center;\"><br/> " + $("#importBox").html() + " </form> "
                $.jBox(uploadText, {title:"导入数据", buttons:{"关闭":true},
                    bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
            });
        });

    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>

<div id="importBox" class="hide" style="z-index:-1;">
        <input name="file_fields" id="file_fields" type="file" style="width:330px"/><br/><br/>　　
        <input id="btnImportSubmit" class="btn btn-primary" style="margin: 0px 0px 3px 0px" type="button" onclick="fileexport();" value="导入"/>
        <a id="downmoban" name="downmoban" style="" style="margin: 1px 1px 3px 1px;float: right;"  href="${ctx}/user/import/template">下载模板</a>
</div>

<div  style="display: none">
</div>


<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="breadcrumb form-search ">
</form:form>
<form:form id="inputForm" modelAttribute="user"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="user.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <spring:message code="loginName" var="mese" />
                    <spring:message code="office" var="omese" />
                    <spring:message code="company" var="cmese" />
                    <div style="float:left;">
                        <form:input placeholder="${mese}" path="loginName" cssClass="form-control"   tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;margin:1px 1px 1px 10px">
                        <sys:treeselect id="company" placeholder="${cmese}" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
                                        title="公司" url="/office/treeData.do?type=1" cssClass="selectcss" allowClear="true"/>
                    </div>
                    <div style="float:left;">
                        <sys:treeselect id="office" name="office.id" placeholder="${omese}" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
                                         title="部门" url="/office/treeData.do?type=2" cssClass="selectcss" allowClear="true" notAllowSelectParent="true"/>
                    </div>
                    <div style="float:left;margin:0px 0px 8px 0px">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>
                    <div style="float:left;">
                        <button class="btn btn-default button-font" name="btnExport" id="btnExport"  type="button" ><i class="fa fa-download"></i></button>
                    </div>
                    <div style="float:left;">
                        <button class="btn btn-default button-font"  type="button" name="impo1rtBox1" id="importBox1"  ><i class="fa fa-sign-in"></i></button>
                    </div>

                    <div style="float:right;">
                        <shiro:hasPermission name="sys:user:edit">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                        </shiro:hasPermission>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th><spring:message code="company" /></th>
                            <th><spring:message code="office" /></th>
                            <th><spring:message code="name" /></th>
                            <th><spring:message code="loginName" /></th>
                            <th><spring:message code="no" /></th>
                            <th ><spring:message code="loginFlag" /></th>
                            <shiro:hasPermission name="sys:user:edit">
                                <th><spring:message code="operation" /></th>
                            </shiro:hasPermission>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="user">
                            <tr>
                                <td>${user.company.name}</td>
                                <td>${user.office.name}</td>
                                <td>${user.name}</td>
                                <td>${user.loginName}</td>
                                <td>${user.no}</td>
                                <c:if test="${user.loginFlag == 1}">
                                    <td><spring:message code="start" /></td>
                                </c:if>
                                <c:if test="${user.loginFlag == 0}">
                                    <td><spring:message code="forbidden" /></td>
                                </c:if>
                                <shiro:hasPermission name="sys:user:edit">
                                    <td nowrap>
                                        <a href="#" onclick="modi('${user.id}');"><spring:message code="edit" /></a>
                                        <a href="#" onclick="return confirmx('<spring:message code="delete.message" />', '<c:url value="${fns:getAdminPath()}/user/delete.do"/>?id=${user.id}')"><spring:message code="delete" /></a>
                                    </td>
                                </shiro:hasPermission>
                            </tr>
                        </c:forEach></tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/user/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>