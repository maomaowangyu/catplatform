<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="office.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        $("#treeTable").treeTable({expandLevel : 3}).show();
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/office/toAddPage.do"/>');
        }


        function modi(officeid) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/office/toModiPage.do"/>',officeid)
        }


    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="office.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>

                    <div style="float:right;">
                        <shiro:hasPermission name="sys:office:edit">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                        </shiro:hasPermission>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th><spring:message code="name" /></th>
                            <th><spring:message code="area.name" /></th>
                            <th><spring:message code="code" /></th>
                            <th ><spring:message code="type" /></th>
                            <shiro:hasPermission name="sys:office:edit">
                                <th><spring:message code="operation" /></th>
                            </shiro:hasPermission>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${list}" var="office">
                            <tr id="${office.id}" pId="${office.parent.id ne '1'?office.parent.id:'0'}">
                                <td>${office.name}</td>
                                <td>${office.area.name}</td>
                                <td>${office.code}</td>
                                <c:forEach items="${fns:getDictList('sys_office_type')}" var="officeType">
                                    <c:if test="${officeType.value == office.type}">
                                        <td>${officeType.label}</td>
                                    </c:if>
                                </c:forEach>
                                <shiro:hasPermission name="sys:office:edit"><td nowrap>
                                    <a href="#" onclick="modi('${office.id}');"><spring:message code="edit" /></a>
                                    <a href="#" onclick="return confirmx('<spring:message code="office.delete.message" />', '<c:url value="${fns:getAdminPath()}/office/delete.do"/>?id=${office.id}')"><spring:message code="delete" /></a>
                                </td></shiro:hasPermission>
                            </tr>
                        </c:forEach></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</form>
</body>
</html>