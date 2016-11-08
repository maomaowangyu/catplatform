<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<html>
<head>
    <title><spring:message code="dict.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        $("#treeTable").treeTable({expandLevel : 3}).show();
        function add() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/dict/toAddPage.do"/>');
        }

        function search() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/dict/list.do"/>');
        }

        function deleteall() {
            layer.confirm('<spring:message code="dict.delete.message" />', {
                btn: ['确定','取消'] //按钮
            }, function(){
                ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/dict/alldelete.do"/>');
            }, function(){

            });
        }


        function modi(id) {
            ajaxPost('<c:url value="${fns:getAdminPath()}/dict/toModiPage.do"/>',id)
        }
        $(document).ready(function() {
            $("#all").click(function(){
                if ($("#all").attr("checked")) {
                     $(":checkbox").attr("checked", true);
                } else {
                   $(":checkbox").attr("checked", false);
                }
            });
        });

    </script>

    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>
<form:form id="inputForm" modelAttribute="dict"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="dict.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <spring:message code="dict.type" var="mese"/>
                    <div style="float:left;">
                        <form:input path="type" placeholder="${mese}"  cssClass="form-control"  tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <div style="float:right;">
                        <shiro:hasPermission name="sys:dict:edit">
                            <button class="btn btn-default button-font"  type="button" onclick="add();"><spring:message code="add" /></button>
                            <button class="btn btn-default button-font"  type="button" onclick="deleteall();"><spring:message code="delete" /></button>
                        </shiro:hasPermission>
                    </div>
                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th style="text-align:center;"><input type="checkbox" id="all" name="all" value="-1"></th>
                            <th><spring:message code="dict.value" /></th>
                            <th><spring:message code="dict.label" /></th>
                            <th><spring:message code="dict.type" /></th>
                            <th ><spring:message code="dict.sort" /></th>
                            <shiro:hasPermission name="sys:dict:edit">
                                <th><spring:message code="operation" /></th>
                            </shiro:hasPermission>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="dict">
                            <tr>
                                <td style="text-align:center;" ><input type="checkbox" id="ids" name="ids" value="${dict.id}"></td>
                                <td>${dict.value}</td>
                                <td>${dict.label}</td>
                                <td>${dict.type}</td>
                                <td>${dict.sort}</td>

                                <shiro:hasPermission name="sys:dict:edit">
                                    <td nowrap>
                                        <c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
                                            <a href="#" onclick="modi('${dict.id}');"><spring:message code="edit" /></a>
                                        </c:if>

                                        <a href="#" onclick="return confirmx('<spring:message code="dict.delete.message" />', '<c:url value="${fns:getAdminPath()}/dict/delete.do"/>?id=${dict.id}')"><spring:message code="delete" /></a>
                                    </td>
                                </shiro:hasPermission>
                            </tr>
                        </c:forEach></tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/dict/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>