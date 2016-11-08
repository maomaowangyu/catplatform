<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<link rel="shortcut icon" href="#" type="image/png">

	<title>404 Page</title>

</head>

<body class="error-page">

<section>
	<div class="container ">

		<section class="error-wrapper text-center">
			<h1><img alt="" src="<c:url value="/adminEx/images/404-error.png"/>"></h1>
			<h2>page not found</h2>
			<h3>We Couldn’t Find This Page</h3>
			<a class="back-btn" href="index.html"> Back To Home</a>
		</section>

	</div>
</section>


</body>
</html>
