<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="table.manger" /></title>
    <head>

    </head>
    <script type="text/javascript">
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/gen/genTable/form.do"/>');
        }

        function search() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/gen/genTable/list.do"/>');
        }


        function modi(id) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/gen/genTable/toModiPage.do"/>',id)
        }
    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>

<div  style="display: none">
</div>
<form:form id="inputForm" modelAttribute="genTable"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="table.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="search();"/>
                    <spring:message code="table.name" var="mese" />
                    <spring:message code="table.comments" var="mese1" />
                    <spring:message code="table.parentTable" var="mese2" />
                    <div style="float:left;margin: 0px 1px 1px 1px;">
                        <form:input placeholder="${mese}" path="nameLike" cssClass="form-control"   tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;margin: 0px 1px 1px 1px;">
                        <form:input placeholder="${mese1}" path="comments" cssClass="form-control"   tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;margin: 0px 1px 1px 1px;">
                        <form:input placeholder="${mese2}" path="parentTable" cssClass="form-control"   tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;margin:0px 0px 8px 0px">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <div style="float:right;">
                        <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th class="sort-column name DESC"><spring:message code="table.name" /></th>
                            <th><spring:message code="table.comments" /></th>
                            <th class="sort-column class_name DESC"><spring:message code="table.className" /></th>
                            <th><spring:message code="table.parentTable" /></th>
                            <th><spring:message code="operation" /></th>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="genTable">
                            <tr>
                                <td>${genTable.name}</td>
                                <td>${genTable.comments}</td>
                                <td>${genTable.className}</td>
                                <td>${genTable.parentTable}</td>
                                <td nowrap>
                                    <a href="#" onclick="modi('${genTable.id}');"><spring:message code="edit" /></a>
                                    <a href="#" onclick="return confirmx('<spring:message code="delete.message" />', '<c:url value="${fns:getAdminPath()}/gen/genTable/delete.do"/>?id=${genTable.id}')"><spring:message code="delete" /></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/gen/genTable/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>