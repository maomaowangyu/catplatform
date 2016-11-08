<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">

    <title>Cat Platform</title>

    <link href="<c:url value="/adminEx/css/style.css"/>" rel="stylesheet">
    <link href="<c:url value="/adminEx/css/style-responsive.css"/>" rel="stylesheet">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<c:url value="/adminEx/js/html5shiv.js"/>"></script>
    <script src="<c:url value="/adminEx/js/respond.min.js"/>"></script>
    <![endif]-->

    <!-- Placed js at the end of the document so the pages load faster -->
    <script src="<c:url value="/adminEx/js/jquery-1.10.2.min.js"/>"></script>
    <script src="<c:url value="/adminEx/js/jquery-1.4.4.min.js"/>"></script>
    <script type="text/javascript">
        var $jq = $.noConflict(true);
    </script>
    <script src="<c:url value="/adminEx/js/jquery-ui-1.9.2.custom.min.js"/>"></script>
    <script src="<c:url value="/adminEx/js/jquery-migrate-1.2.1.min.js"/>"></script>
    <script src="<c:url value="/adminEx/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/adminEx/js/modernizr.min.js"/>"></script>
    <script src="<c:url value="/adminEx/js/jquery.nicescroll.js"/>"></script>
    <link href="<c:url value="/static/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css"/>" rel="stylesheet" />
    <script src="<c:url value="/static/jquery-jbox/2.3/jquery.jBox-2.3.min.js"/>" type="text/javascript"></script>
    <link href="<c:url value="/static/common/baseplatform.css"/>" type="text/css" rel="stylesheet" />
    <script src="<c:url value="/static/common/baseplatform.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/layer/layer.js"/>"></script>
    <link href="<c:url value="/static/jquery-select2/4.0.3/css/select2.min.css"/>" rel="stylesheet" />
    <script src="<c:url value="/static/jquery-select2/4.0.3/js/select2.full.js"/>" type="text/javascript"></script>
    <link href="<c:url value="/static/jquery-validation/1.11.0/jquery.validate.css"/>" type="text/css" rel="stylesheet" />
    <script src="<c:url value="/static/jquery-validation/1.11.0/jquery.validate.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/jquery-validation/1.11.0/jquery.validate.method.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/jquery-validation/1.11.0/lib/jquery.form.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/jquery-validation/custommethod.js"/>" type="text/javascript"></script>

    <link href="<c:url value="/static/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css"/>" rel="stylesheet" />
    <script src="<c:url value="/static/jquery-jbox/2.3/jquery.jBox-2.3.min.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/My97DatePicker/WdatePicker.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/static/common/mustache.min.js"/>" type="text/javascript"></script>
    <link href="<c:url value="/static/treeTable/themes/vsStyle/treeTable.min.css"/>" rel="stylesheet" type="text/css" />
    <link href="<c:url value="/static/main.css"/>" rel="stylesheet" type="text/css" />
    <script src="<c:url value="/static/treeTable/jquery.treeTable.min.js"/>" type="text/javascript"></script>


    <style type="text/css">
        body { font-size:14px; font-family:"微软雅黑"}
    </style>
</head>

<body class="sticky-header">

<section>
    <!-- left side start-->
    <div class="left-side sticky-left-side">

        <!--logo and iconic logo start-->
        <div class="logo">
            <a href="#"><img src="<c:url value="/adminEx/images/login-logo.png"/>" alt=""></a>
        </div>

        <div class="logo-icon text-center">
            <a href="index.html"><img src="<c:url value="/adminEx/images/logo_icon.png"/>" alt=""></a>
        </div>
        <!--logo and iconic logo end-->


        <div class="left-side-inner">

            <!-- visible to small devices only -->
            <div class="visible-xs hidden-sm hidden-md hidden-lg">
                <div class="media logged-user">
                    <img alt="" src="<c:url value="/adminEx/images/photos/user-avatar.png"/>" class="media-object">
                    <div class="media-body">
                        <h4><a href="#">John Doe </a></h4>
                        <span>"Hello There..."</span>
                    </div>
                </div>

                <h5 class="left-nav-title">Account Information</h5>
                <ul class="nav nav-pills nav-stacked custom-nav">
                    <li><a href="#"><i class="fa fa-user"></i> <span>Profile</span></a></li>
                    <li><a href="#"><i class="fa fa-cog"></i> <span>Settings</span></a></li>
                    <li><a href="${ctx}/logout.do"><i class="fa fa-sign-out"></i> <span>Sign Out</span></a></li>
                </ul>
            </div>

            <!--sidebar nav start-->
            <ul id="leftMenu"  name="leftMenu" class="nav nav-pills nav-stacked custom-nav">

            <c:forEach items="${fns:getLeftMenuList()}" var="menu" varStatus="idxStatus">

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
                      <c:forEach items="${fns:getLeftLeaceMenuList()}" var="lmenu" varStatus="idxStatus">
                          <c:if test="${lmenu.parentfId == menu.id}">
                              <c:set var="url" value="${lmenu.href}"></c:set>
                              <c:if test="${sessionScope.user.diglossia == 0}">
                                  <c:if test="${lmenu.externalLinks == '0'}">
                                      <li style="font-family : 微软雅黑;"><a href="#" onclick="leftmain('<c:url value="${url}"/>');"> <c:out value="${lmenu.name}"/></a></li>
                                  </c:if>
                                  <c:if test="${lmenu.externalLinks == '1'}">
                                      <li style="font-family : 微软雅黑;"><a href="#" onclick="externalleftmain('<c:url value="${url}"/>');"> <c:out value="${lmenu.name}"/></a></li>
                                  </c:if>
                              </c:if>
                              <c:if test="${sessionScope.user.diglossia == 1}">
                                  <c:if test="${lmenu.externalLinks == '0'}">
                                      <li style="font-family : 微软雅黑;"><a href="#" onclick="leftmain('<c:url value="${url}"/>');"> <c:out value="${lmenu.sname}"/></a></li>
                                  </c:if>
                                  <c:if test="${lmenu.externalLinks == '1'}">
                                      <li style="font-family : 微软雅黑;"><a href="#" onclick="externalleftmain('<c:url value="${url}"/>');"> <c:out value="${lmenu.sname}"/></a></li>
                                  </c:if>
                              </c:if>
                          </c:if>
                      </c:forEach>
                    </ul>
                </li>
            </c:forEach>


            </ul>
            <!--sidebar nav end-->

        </div>
    </div>
    <!-- left side end-->

    <!-- main content start-->
    <div class="main-content" >

        <!-- header section start-->
        <div class="header-section">

            <!--toggle button start-->
            <a class="toggle-btn"><i class="fa fa-bars"></i></a>
            <!--toggle button end-->

            <!--across menu start-->
            <div class="menu-left">
            <c:forEach items="${fns:getMenuListByLeaveOne()}" var="menu" varStatus="idxStatus">
                <ul id="hmenu" name="<c:out value="${menu.id}"/>" class="notification-menu hmenu" style="margin-bottom:0px;">
                    <li>
                        <a href="#" class="btn btn-default dropdown-toggle1 info-number1" data-toggle="dropdown" >
                            <c:if test="${not empty menu.icon}">
                            <i class="fa ${menu.icon}"></i>
                            </c:if>
                            <c:if test="${empty menu.icon}">
                                <i class="fa fa-cog"></i>
                            </c:if>

                            <c:if test="${sessionScope.user.diglossia == 0}">
                                <c:out value="${menu.name}"/>
                            </c:if>
                            <c:if test="${sessionScope.user.diglossia == 1}">
                                <c:out value="${menu.sname}"/>
                            </c:if>
                        </a>
                    </li>
                </ul>
            </c:forEach>
            </div>
            <!--across menu end-->

            <!--notification menu start -->
            <div class="menu-right">
                <ul class="notification-menu">
                    <li>
                        <a href="#" class="btn btn-default dropdown-toggle info-number" data-toggle="dropdown">
                            <i class="fa fa-tasks"></i>
                            <span class="badge">8</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-head pull-right">
                            <h5 class="title">You have 8 pending task</h5>
                            <ul class="dropdown-list user-list">
                                <li class="new">
                                    <a href="#">
                                        <div class="task-info">
                                            <div>Database update</div>
                                        </div>
                                        <div class="progress progress-striped">
                                            <div style="width: 40%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-warning">
                                                <span class="">40%</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="new">
                                    <a href="#">
                                        <div class="task-info">
                                            <div>Dashboard done</div>
                                        </div>
                                        <div class="progress progress-striped">
                                            <div style="width: 90%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="90" role="progressbar" class="progress-bar progress-bar-success">
                                                <span class="">90%</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <div class="task-info">
                                            <div>Web Development</div>
                                        </div>
                                        <div class="progress progress-striped">
                                            <div style="width: 66%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="66" role="progressbar" class="progress-bar progress-bar-info">
                                                <span class="">66% </span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <div class="task-info">
                                            <div>Mobile App</div>
                                        </div>
                                        <div class="progress progress-striped">
                                            <div style="width: 33%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="33" role="progressbar" class="progress-bar progress-bar-danger">
                                                <span class="">33% </span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <div class="task-info">
                                            <div>Issues fixed</div>
                                        </div>
                                        <div class="progress progress-striped">
                                            <div style="width: 80%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="80" role="progressbar" class="progress-bar">
                                                <span class="">80% </span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="new"><a href="">See All Pending Task</a></li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="btn btn-default dropdown-toggle info-number" data-toggle="dropdown">
                            <i class="fa fa-envelope-o"></i>
                            <span class="badge">5</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-head pull-right">
                            <h5 class="title">You have 5 Mails </h5>
                            <ul class="dropdown-list normal-list">
                                <li class="new">
                                    <a href="">
                                        <span class="thumb"><img src="<c:url value="/adminEx/images/photos/user1.png"/>" alt="" /></span>
                                        <span class="desc">
                                          <span class="name">John Doe <span class="badge badge-success">new</span></span>
                                          <span class="msg">Lorem ipsum dolor sit amet...</span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="thumb"><img src="<c:url value="/adminEx/images/photos/user2.png"/>" alt="" /></span>
                                        <span class="desc">
                                          <span class="name">Jonathan Smith</span>
                                          <span class="msg">Lorem ipsum dolor sit amet...</span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="thumb"><img src="<c:url value="/adminEx/images/photos/user3.png"/>" alt="" /></span>
                                        <span class="desc">
                                          <span class="name">Jane Doe</span>
                                          <span class="msg">Lorem ipsum dolor sit amet...</span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="thumb"><img src="<c:url value="/adminEx/images/photos/user4.png"/>" alt="" /></span>
                                        <span class="desc">
                                          <span class="name">Mark Henry</span>
                                          <span class="msg">Lorem ipsum dolor sit amet...</span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="thumb"><img src="<c:url value="/adminEx/images/photos/user5.png"/>" alt="" /></span>
                                        <span class="desc">
                                          <span class="name">Jim Doe</span>
                                          <span class="msg">Lorem ipsum dolor sit amet...</span>
                                        </span>
                                    </a>
                                </li>
                                <li class="new"><a href="">Read All Mails</a></li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="btn btn-default dropdown-toggle info-number" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                            <span class="badge">4</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-head pull-right">
                            <h5 class="title">Notifications</h5>
                            <ul class="dropdown-list normal-list">
                                <li class="new">
                                    <a href="">
                                        <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                                        <span class="name">Server #1 overloaded.  </span>
                                        <em class="small">34 mins</em>
                                    </a>
                                </li>
                                <li class="new">
                                    <a href="">
                                        <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                                        <span class="name">Server #3 overloaded.  </span>
                                        <em class="small">1 hrs</em>
                                    </a>
                                </li>
                                <li class="new">
                                    <a href="">
                                        <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                                        <span class="name">Server #5 overloaded.  </span>
                                        <em class="small">4 hrs</em>
                                    </a>
                                </li>
                                <li class="new">
                                    <a href="">
                                        <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                                        <span class="name">Server #31 overloaded.  </span>
                                        <em class="small">4 hrs</em>
                                    </a>
                                </li>
                                <li class="new"><a href="">See All Notifications</a></li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                ${sessionScope.user.loginName}
                               <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                            <li><a href="#"><i class="fa fa-user"></i>  Profile</a></li>
                            <li><a href="#"><i class="fa fa-cog"></i>  Settings</a></li>
                            <li><a href="${ctx}/logout.do"><i class="fa fa-sign-out"></i><spring:message code="LoginOut" /></a></li>
                        </ul>
                    </li>

                </ul>
            </div>
            <!--notification menu end -->

        </div>
        <!-- header section end-->



        <!--body wrapper start-->
        <div id="content_main" class="wrapper">
            <!--Vector Maps-->
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/jquery.vmap.js"/>"></script>
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/maps/jquery.vmap.world.js"/>"></script>
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/data/jquery.vmap.sampledata.js"/>"></script>
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/maps/continents/jquery.vmap.europe.js"/>"></script>
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/maps/continents/jquery.vmap.asia.js"/>"></script>
            <script src="<c:url value="/adminEx/js/jvector-map/jqvmap/maps/continents/jquery.vmap.australia.js"/>"></script>

            <div class="row">
                <div class="col-sm-12">
                    <section class="panel">
                        <header class="panel-heading">
                            WORLD MAP
                        <span class="tools pull-right">
                            <a href="javascript:;" class="fa fa-chevron-down"></a>
                            <a href="javascript:;" class="fa fa-times"></a>
                         </span>
                        </header>
                        <div class="panel-body">
                            <div id="world-vmap" class="vmaps"></div>
                        </div>
                    </section>
                </div>
            </div>


            <script>
                jQuery('#world-vmap').vectorMap({
                    map: 'world_en',
                    backgroundColor: null,
                    color: '#ffffff',
                    hoverOpacity: 0.7,
                    selectedColor: '#666666',
                    enableZoom: true,
                    borderWidth:1,
                    showTooltip: true,
                    values: sample_data,
                    scaleColors: ['#d3d3d3', '#262626'],
                    normalizeFunction: 'polynomial'
                });
            </script>
        </div>
        <!--body wrapper end-->

        <!--footer section start-->
        <footer>
            Cat Platform by galaxy  2007-2016
        </footer>
        <!--footer section end-->


    </div>
    <!-- main content end-->
</section>




<script type="text/javascript">
    jQuery('.hmenu').click(function(){
        layerLoadingShow();
        $.ajax({
            type: "post",
            url: '<c:url value="${fns:getAdminPath()}/menu/leftmenu.do"/>',
            data: {id:$(this).attr("name")},
            dataType: "html",
            success: function(data){
                $("#leftMenu").empty();
                $("#leftMenu").append(data);
                layerLoadinghiden();
                //console.log("log！");
            }, error:function(){
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
    });

    <%--$.ajaxSetup({--%>
        <%--contentType:"application/x-www-form-urlencoded;charset=utf-8",--%>
        <%--complete:function(XMLHttpRequest,textStatus){--%>
            <%--//通过XMLHttpRequest取得响应头，sessionstatus，--%>
            <%--var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus");--%>
            <%--if(sessionstatus=="timeout"){--%>
                <%--//如果超时就处理 ，指定要跳转的页面--%>
                <%--window.location = "<c:url value="/" />";--%>
            <%--}--%>
        <%--}--%>
    <%--});--%>

    function leftmain(url) {
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

    function externalleftmain(url) {
        var h = "<iframe width='100%' height='100%' id='content_iframe' name='content_iframe' src='"+url+"' ></iframe>"
        $("#content_main").empty();
        $("#content_main").append(h);
    }
</script>
<!--common scripts for all pages-->
<script src="<c:url value="/adminEx/js/scripts.js"/>"></script>

</body>
</html>
