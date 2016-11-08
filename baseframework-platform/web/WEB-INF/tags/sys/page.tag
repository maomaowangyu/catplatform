<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="page" type="com.galaxy.common.persistence.Page" required="true" description="分页实体类"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="分页实体类"%>
<script>
    function previous() {
        $("#pageNo").val("1");
        ajaxSubmitPost('<c:url value="${url}"/>');
    }

    function next() {
        $("#pageNo").val($("#totalpage").val());
        ajaxSubmitPost('<c:url value="${url}"/>');
    }

    function goNum(num) {
        $("#pageNo").val(num);
        ajaxSubmitPost('<c:url value="${url}"/>');
    }

    $(document).ready(function() {
        var pageNoVal =  $("#pageNo").val();
        $("#"+pageNoVal).attr("class","active");
        $("#"+pageNoVal).css("color","#fff");
    });

</script>

<style type="text/css">
    .active { font-size:14px; font-family:"微软雅黑"; background: #65cea7;}
</style>
<div class="dataTables_paginate paging_bootstrap pagination">
    <input type="hidden" id="pageNo" name="pageNo"  value="<c:out value="${page.pageNo}"/>"/>
    <input type="hidden" id="totalpage" name="totalpage"  value="<c:out value="${page.last}"/>"/>
    <ul>
        <li><a href="#" onclick="previous()">← <spring:message code="first" /></a></li>
        <%--<li class="active"><a href="#">1</a></li>--%>

        <c:forEach items="${page.pageNumList}" var="a">
            <li ><a id="<c:out value="${a}"/>"  href="#" onclick="goNum('<c:out value="${a}"/>')"><c:out value="${a}"/></a></li>
        </c:forEach>
        <li class="next"><a href="#"  onclick="next()"><spring:message code="last" /> → </a></li>
    </ul>
</div>
