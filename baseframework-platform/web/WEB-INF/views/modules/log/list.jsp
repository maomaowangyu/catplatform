<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <title><spring:message code="log.manage" /></title>
    <head>

    </head>
    <script type="text/javascript">
        function search() {
        ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/log/list.do"/>');
        }
    </script>
    <style type="text/css">
        .button-font { font-size:14px; font-family:"微软雅黑";margin: 3px;}
    </style>
</head>
<body>
<form:form id="inputForm" modelAttribute="log"  method="post" class="cmxform form-horizontal adminex-form">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <spring:message code="log.list" />
                                    <span class="tools pull-right">
                                        <a href="javascript:;" class="fa fa-chevron-down"></a>
                                        <a href="javascript:;" class="fa fa-times"></a>
                                     </span>
                </div>
                <div class="panel-body">
                    <sys:message content="${message}" type="${flag}"/>
                    <spring:message code="log.title" var="mese"/>
                    <div style="float:left;margin:1px 1px 1px 5px">
                        <form:input path="title" placeholder="${mese}"  cssClass="form-control"  tmlEscape="false" maxlength="50"/>
                    </div>
                    <spring:message code="log.remoteAddr" var="uri"/>
                    <div style="float:left;margin:1px 1px 1px 5px">
                        <form:input path="remoteAddr" placeholder="${uri}"  cssClass="form-control"  tmlEscape="false" maxlength="50"/>
                    </div>
                    <spring:message code="log.createBy.name" var="createByname"/>
                    <div style="float:left;margin:1px 1px 1px 5px">
                        <form:input path="createBy.name" placeholder="${createByname}"  cssClass="form-control"  tmlEscape="false" maxlength="50"/>
                    </div>
                    <div style="float:left;margin:1px 1px 1px 5px">
                        <input id="beginDate" name="beginDate" type="text" height="33px" width="25px"  readonly="readonly" maxlength="20" class="form-control  Wdate"
                               value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    </div>
                    <div style="float:left;margin:1px 1px 1px 5px">
                        <input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" width="25px" height="33px" class="form-control Wdate"
                               value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    </div>

                    <div style="float:left;margin:1px 1px 1px 5px">
                        <button class="btn btn-default button-font"  type="button" onclick="search();"><i class="fa fa-search"></i></button>
                    </div>

                    <table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
                        <thead><tr>
                            <th><spring:message code="log.title" /></th>
                            <th><spring:message code="log.createBy.name" /></th>
                            <th><spring:message code="log.createBy.company.name" /></th>
                            <th ><spring:message code="log.createBy.office.name" /></th>
                            <th ><spring:message code="log.requestUri" /></th>
                            <th ><spring:message code="log.method" /></th>
                            <th ><spring:message code="log.remoteAddr" /></th>
                            <th ><spring:message code="log.createDate" /></th>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="log">
                            <tr>
                                <td>${log.title}</td>
                                <td>${log.createBy.name}</td>
                                <td>${log.createBy.company.name}</td>
                                <td>${log.createBy.office.name}</td>
                                <td>${log.requestUri}</td>
                                <td>${log.method}</td>
                                <td>${log.remoteAddr}</td>
                                <td><fmt:formatDate value="${log.createDate}" type="both"/></td>
                            </tr>
                        </c:forEach></tbody>
                    </table>
                    <sys:page page="${page}" url="${fns:getAdminPath()}/log/list.do"/>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>