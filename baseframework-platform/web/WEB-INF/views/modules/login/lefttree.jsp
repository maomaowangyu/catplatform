<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>

<c:forEach items="${lmenuList}" var="menu" varStatus="idxStatus">
    <li class="menu-list">
        <a href="#">
            <c:if test="${not empty menu.icon}">
                <i class="fa ${menu.icon}"></i>
            </c:if>
            <c:if test="${empty menu.icon}">
                <i class="fa fa-home"></i>
            </c:if>
            <c:if test="${sessionScope.user.diglossia == 0}">
                <span style="font-family : 微软雅黑;"> <c:out value="${menu.name}"/></span></a>
            </c:if>
            <c:if test="${sessionScope.user.diglossia == 1}">
                <span style="font-family : 微软雅黑;"> <c:out value="${menu.sname}"/></span></a>
            </c:if>
        <ul class="sub-menu-list">
            <c:forEach items="${menuList}" var="lmenu" varStatus="idxStatus">
                <c:if test="${lmenu.parentfId == menu.id}">
                    <c:set var="url" value="${lmenu.href}"></c:set>
                    <c:if test="${sessionScope.user.diglossia == 0}">
                        <c:if test="${lmenu.externalLinks == '0'}">
                            <li style="font-family : 微软雅黑;"><a href="#" onclick="left('<c:url value="${url}"/>');"> <c:out value="${lmenu.name}"/></a></li>
                        </c:if>
                        <c:if test="${lmenu.externalLinks == '1'}">
                            <li style="font-family : 微软雅黑;"><a href="#" onclick="externalleft('<c:url value="${url}"/>');"> <c:out value="${lmenu.name}"/></a></li>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.user.diglossia == 1}">
                        <c:if test="${lmenu.externalLinks == '0'}">
                            <li style="font-family : 微软雅黑;"><a href="#" onclick="left('<c:url value="${url}"/>');"> <c:out value="${lmenu.sname}"/></a></li>
                        </c:if>
                        <c:if test="${lmenu.externalLinks == '1'}">
                            <li style="font-family : 微软雅黑;"><a href="#" onclick="externalleft('<c:url value="${url}"/>');"> <c:out value="${lmenu.sname}"/></a></li>
                        </c:if>
                    </c:if>
                </c:if>
            </c:forEach>
        </ul>
    </li>
</c:forEach>


</body>

<script type="text/javascript">

    <%--$.ajaxSetup({--%>
        <%--contentType:"application/x-www-form-urlencoded;charset=utf-8",--%>
        <%--complete:function(XMLHttpRequest,textStatus){--%>
            <%--//通过XMLHttpRequest取得响应头，sessionstatus，--%>
            <%--var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus");--%>
            <%--alert(sessionstatus);--%>
            <%--if(sessionstatus=="timeout"){--%>
                <%--//如果超时就处理 ，指定要跳转的页面--%>
                <%--window.location = "<c:url value="/" />";--%>
            <%--}--%>
        <%--}--%>
    <%--});--%>

    function left(url) {
        layerLoadingShow();

        $.ajax({
            type: "get",
            url: url,
            dataType: "html",
            success: function (data) {
                $("#content_main").empty();
                $("#content_main").append(data);
                layerLoadinghiden();

                //console.log("log！");
            }, error: function () {
                alert("异步失败");
                layerLoadinghiden();
            }  , complete:function(XMLHttpRequest,textStatus){
                //通过XMLHttpRequest取得响应头，sessionstatus，
                var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus");
                if(sessionstatus=="timeout"){
                    //如果超时就处理 ，指定要跳转的页面
                    window.location = "<c:url value="/" />";
                }
            }
        });
    }

    function externalleft(url) {
        var h = "<iframe width='100%' height='100%' id='content_iframe' name='content_iframe' src='"+url+"' ></iframe>"
        $("#content_main").empty();
        $("#content_main").append(h);
    }
</script>
</html>
