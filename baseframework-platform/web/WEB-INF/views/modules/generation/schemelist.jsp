<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="scheme.manger" /></title>
    <head>

    </head>
    <script type="text/javascript">
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/gen/genScheme/toAddPage.do"/>');
        }

        function search() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/gen/genScheme/list.do"/>');
        }


        function modi(id) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/gen/genScheme/toModiPage.do"/>',id)
        }
    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>

<div  style="display: none">
</div>
<form:form id="inputForm" modelAttribute="genScheme"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="scheme.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <spring:message code="scheme.name" var="mese" />
                    <div style="float:left;">
                        <form:input placeholder="${mese}" path="name" cssClass="form-control"   tmlEscape="false" maxlength="50"/>
                    </div>

                    <div style="float:left;margin:0px 0px 8px 0px">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <div style="float:right;">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th><spring:message code="scheme.name" /></th>
                            <th><spring:message code="scheme.packagename" /></th>
                            <th><spring:message code="scheme.modulename" /></th>
                            <th><spring:message code="scheme.functionname" /></th>
                            <th><spring:message code="scheme.functionauthor" /></th>
                            <th><spring:message code="operation" /></th>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="genScheme">
                            <tr>
                                <td>${genScheme.name}</td>
                                <td>${genScheme.packageName}</td>
                                <td>${genScheme.moduleName}${not empty genScheme.subModuleName?'.':''}${genScheme.subModuleName}</td>
                                <td>${genScheme.functionName}</td>
                                <td>${genScheme.functionAuthor}</td>
                                    <td nowrap>
                                        <a href="#" onclick="modi('${genScheme.id}');"><spring:message code="edit" /></a>
                                        <a href="#" onclick="return confirmx('<spring:message code="delete.message" />', '<c:url value="${fns:getAdminPath()}/gen/genScheme/delete.do"/>?id=${genScheme.id}')"><spring:message code="delete" /></a>
                                    </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/gen/genScheme/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>