<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>


<html>
<head>
    <title><spring:message code="menu.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        $("#treeTable").treeTable({expandLevel : 3}).show();
        function add() {
            <%--layer.open({--%>
                <%--type: 2,--%>
                <%--title: '<spring:message code="menu.add" />',--%>
                <%--fix: false,--%>
                <%--shadeClose: true,--%>
                <%--maxmin: true,--%>
                <%--area: ['1000px', '500px'],--%>
                <%--content: '<c:url value="/backstage/menu/toAddPage.do" />'--%>
            <%--});--%>
            ajaxGet('<c:url value="${fns:getAdminPath()}/menu/toAddPage.do"/>');
        }

        function saveOrder() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/menu/updateSort.do"/>');

        }

        function modi(menuid) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/menu/toModiPage.do"/>',menuid)

        }


    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>
<form id="inputForm" name="inputForm" method="post">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="menu.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>

                    <div style="float:right;">
                        <shiro:hasPermission name="sys:menu:edit">
                        <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                        <button class="btn btn-default button-font" type="button" onclick="saveOrder();"><spring:message code="save" /></button>
                        </shiro:hasPermission>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr><th><spring:message code="name" /></th><th><spring:message code="href" /></th><th style="text-align:center;"><spring:message code="sort" /></th><th><spring:message code="visible" /></th><th><spring:message code="permission" /></th><shiro:hasPermission name="sys:menu:edit"><th><spring:message code="operation" /></th></shiro:hasPermission></tr></thead>
                        <tbody><c:forEach items="${list}" var="menu">
                            <tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
                                <td nowrap><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i>
                                    <c:if test="${sessionScope.user.diglossia == 0}">
                                ${menu.name}
                                    </c:if>

                                    <c:if test="${sessionScope.user.diglossia == 1}">
                                        ${menu.sname}
                                    </c:if>
                                </td>
                                <td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
                                <td style="text-align:center;">
                                    <shiro:hasPermission name="sys:menu:edit">
                                        <input type="hidden" name="ids" value="${menu.id}"/>
                                        <input name="sorts" type="text" value="${menu.sort}" style="width:50px;margin:0;padding:0;text-align:center;">
                                    </shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
                                    ${menu.sort}
                                </shiro:lacksPermission>
                                </td>
                                <c:if test="${sessionScope.user.diglossia == 0}">
                                    <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                                </c:if>
                                <c:if test="${sessionScope.user.diglossia == 1}">
                                    <td>${menu.isShow eq '1'?'show':'hide'}</td>
                                </c:if>
                                <td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
                                <shiro:hasPermission name="sys:menu:edit"><td nowrap>
                                    <a href="#" onclick="modi('${menu.id}');"><spring:message code="edit" /></a>
                                    <a href="#" onclick="return confirmx('<spring:message code="menu.delete.message" />', '<c:url value="${fns:getAdminPath()}/menu/delete.do"/>?id=${menu.id}')"><spring:message code="delete" /></a>
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