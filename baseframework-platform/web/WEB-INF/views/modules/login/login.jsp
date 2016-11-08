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

    <title>Login</title>

    <link href="<c:url value="/adminEx/css/style.css"/>" rel="stylesheet">
    <link href="<c:url value="/adminEx/css/style-responsive.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<c:url value="/adminEx/js/html5shiv.js"/>"></script>
    <script src="<c:url value="/adminEx/js/respond.min.js"/>"></script>
    <![endif]-->
</head>

<body class="login-body">

<div class="container">

    <form class="form-signin" action="<c:url value="/login/login.do"/>"   method="post">
        <div class="form-signin-heading text-center" style="padding:0px;">
            <h1 class="sign-title">Sign In</h1>
            <img src="<c:url value="/adminEx/images/login-logo.jpg"/>"  alt="" width="300px"/>
        </div>
            <div id="messageBox" style="text-align: center;padding:3px;" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
                <label id="loginError" style="text-align: center;" class="error">${message}</label>
            </div>
        <div class="login-wrap">


            <input type="text" class="form-control" name="username" id="username" placeholder="User ID" autofocus>
            <input type="password" id="password" name="password" class="form-control" placeholder="Password">
            <c:if test="${isValidateCodeLogin}">
                <div class="validateCode">
                    <label class="input-label mid" for="validateCode">验证码</label>
                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                </div>
            </c:if>

            <button class="btn btn-lg btn-login btn-block" type="submit">
                <i class="fa fa-check"></i>
            </button>

            <div class="registration">

            </div>
            <label class="checkbox">

                <span class="pull-right">
                    <a data-toggle="modal" href="#myModal"></a>

                </span>
            </label>

        </div>

        <!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Forgot Password ?</h4>
                    </div>
                    <div class="modal-body">
                        <p>Enter your e-mail address below to reset your password.</p>
                        <input type="text" name="email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix">

                    </div>


                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
                        <button class="btn btn-primary" type="button">Submit</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal -->

    </form>

</div>



<!-- Placed js at the end of the document so the pages load faster -->

<!-- Placed js at the end of the document so the pages load faster -->
<script src="<c:url value="/adminEx/js/jquery-1.10.2.min.js"/>"></script>
<script src="<c:url value="/adminEx/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/adminEx/js/modernizr.min.js"/>"></script>

</body>
</html>
