<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="role.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        $("#treeTable").treeTable({expandLevel : 3}).show();
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/role/toAddPage.do"/>');
        }

        function search() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/role/list.do"/>');
        }


        function modi(id) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/role/toModiPage.do"/>',id)
        }


    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>
<form:form id="inputForm" modelAttribute="role"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="role.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <spring:message code="name" var="mese"/>
                    <div style="float:left;">
                        <form:input path="serchname" placeholder="${mese}"  cssClass="form-control"  tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <div style="float:right;">
                        <shiro:hasPermission name="sys:role:edit">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                        </shiro:hasPermission>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th><spring:message code="name" /></th>
                            <th><spring:message code="ename" /></th>
                            <th><spring:message code="dpt" /></th>
                            <th ><spring:message code="scope" /></th>
                            <shiro:hasPermission name="sys:role:edit">
                                <th><spring:message code="operation" /></th>
                            </shiro:hasPermission>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="role">
                            <tr>
                                <td>${role.name}</td>
                                <td>${role.enname}</td>
                                <td>${role.office.name}</td>
                                <td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>

                                <shiro:hasPermission name="sys:role:edit">
                                <td nowrap>
                                    <c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
                                        <a href="#" onclick="modi('${role.id}');"><spring:message code="edit" /></a>
                                    </c:if>

                                    <a href="#" onclick="return confirmx('<spring:message code="role.delete.message" />', '<c:url value="${fns:getAdminPath()}/role/delete.do"/>?id=${role.id}')"><spring:message code="delete" /></a>
                                </td>
                                </shiro:hasPermission>
                            </tr>
                        </c:forEach></tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/role/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>