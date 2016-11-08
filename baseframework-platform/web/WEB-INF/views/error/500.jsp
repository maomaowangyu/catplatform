<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/list.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="#" type="image/png">

	<title>500 Page</title>


</head>

<body class="error-page">

<section>
	<div class="container ">

		<section class="error-wrapper text-center">
			<h1><img alt="" src="<c:url value="/adminEx/images/500-error.png"/>"></h1>
			<h2>OOOPS!!!</h2>
			<h3>Something went wrong.</h3>
			<p class="nrml-txt">Why not try refreshing you page? Or you can <a href="#">contact our support</a> if the problem persists.</p>
			<a class="back-btn" href="#"> Back To Home</a>
		</section>

	</div>
</section>\

</body>
</html>
