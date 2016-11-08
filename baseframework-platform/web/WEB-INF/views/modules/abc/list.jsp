<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
	<title>abcd管理</title>
	<script type="text/javascript">
	        $("#treeTable").treeTable({expandLevel : 3}).show();

		$(document).ready(function() {

		});
	    function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/abc/testTree/toAddPage.do"/>');
        }

		function search() {
			ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/abc/testTree/list.do"/>');
		}


		function modi(id) {
			ajaxPost('<c:url value="${fns:getAdminPath()}/abc/testTree/toModiPage.do"/>',id)
		}
	</script>

	 <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
     </style>
</head>
<body>
	<form:form id="inputForm" modelAttribute="testTree" method="post" class="cmxform form-horizontal adminex-form">
	<div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    列表
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

<style type="text/css">
    .div-broder {margin: 5px 5px 5px 5px}
</style>
<div style="width: 800px">
            <div style="float:left;" class="div-broder">
                    <form:input path="name" placeholder="名称" htmlEscape="false" maxlength="100" class="form-control"/>
            </div>

</div>

                    <div style="float:left;">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <div style="float:right;">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                    </div>

<table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
    <thead>
    <tr>
                <th>名称</th>
                <th>排序</th>
                <th>更新时间</th>
                <th>备注信息</th>
        <shiro:hasPermission name="sys:role:edit">
            <th><spring:message code="operation" /></th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="testTree">
        <tr id="${testTree.id}" pId="${testTree.parent.id ne '1'?testTree.parent.id:'0'}">
                    <td>
                        ${testTree.name}
                    </td>
                    <td>
                        ${testTree.sort}
                    </td>
                    <td>
                            <fmt:formatDate value="${testTree.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                        ${testTree.remarks}
                    </td>

            <shiro:hasPermission name="abc:testTree:edit">
                <td nowrap>
                    <a href="#" onclick="modi('${testTree.id}');"><spring:message code="edit" /></a>
                    <a href="#" onclick="return confirmx('是否要删除该信息', '<c:url value="${fns:getAdminPath()}/abc/testTree/delete.do"/>?id=${testTree.id}')"><spring:message code="delete" /></a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach></tbody>
</table>

                    <sys:page page="${page}" url="${fns:getAdminPath()}/testTree/list.do"/>
                </div>
            </div>
        </div>
    </div>
	</form:form>
</body>
</html>