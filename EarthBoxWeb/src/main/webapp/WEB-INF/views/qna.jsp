<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
response.setContentType("text/html; charset=utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>GreenFair</title>

<!--    Google Fonts-->
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800'
	rel='stylesheet' type='text/css'>

<!--Fontawesom-->
<link rel="stylesheet" href="css/font-awesome.min.css">

<!--Animated CSS-->
<link rel="stylesheet" type="text/css" href="css/animate.min.css">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!--Bootstrap Carousel-->
<link type="text/css" rel="stylesheet" href="css/carousel.css" />

<link rel="stylesheet" href="css/isotope/style.css">

<!--Main Stylesheet-->
<link href="css/style.css" rel="stylesheet">
<!--Responsive Framework-->
<link href="css/responsive.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

</head>
<body data-spy="scroll" data-target="#header">
	<%
	String result = (String) session.getAttribute("user_id");
	System.out.println("qna 게시판 session : " + result);
	%>

	<!--Start Hedaer Section-->
	<section id="header">
		<div class="header-area">
			<!--End of top header-->
			<div class="header_menu text-center" data-spy="affix"
				data-offset-top="50" id="nav">
				<div class="container">
					<nav class="navbar navbar-default zero_mp ">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1"
								aria-expanded="false">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<a class="navbar-brand custom_navbar-brand" href="index.do"><img
								src="img/foruslogo3.png" style="width: 60px; height: 60px">EarthBox</a>
						</div>
						<!--End of navbar-header-->

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse zero_mp"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav navbar-right main_menu">
								<%
								if (result == null) {
								%>
								<li><a href="loginForm.do">로그인</a></li>
								<li><a href="qnaBoard.do">QnA</a></li>
								<li><a href="event.do">공지사항</a></li>
								<!-- 로그인 한 상태 -->
								<%
								} else if (result.equals("admin")) {
								%>
								<li><a href="logout.do">로그아웃</a></li>
								<li><a href="qnaBoard.do?user_id=${result }">QnA</a></li>
								<li><a href="streaming.do">CCTV</a></li>
								<li><a href="event.do">공지사항</a></li>
								<%
								} else {
								%>
								<li><a href="logout.do">로그아웃</a></li>
								<li><a href="qnaBoard.do?user_id=${result }">QnA</a></li>
								<li><a href="event.do">공지사항</a></li>
							</ul>
							<%
							}
							%>
						</div>
						<!-- /.navbar-collapse -->
					</nav>
					<!--End of nav-->
				</div>
				<!--End of container-->
			</div>
			<!--End of header menu-->
		</div>
		<!--end of header area-->
	</section>
	<!--End of Hedaer Section-->


	<h2 class="text-center"
		style="margin-top: 150px; margin-bottom: 50px; font-family: 'Noto Sans KR', sans-serif">Q&A</h2>
	<div class="panel-body">

		<!-- 게시글 검색 기능 -->
		<div class="row">
			<div class='col-sm-2 col-sm-offset-8'>
				<input id='search' type='text' class='form-control'>
			</div>
			<div>
				<button id="searchBtn" type="button" class="btn btn-sm btn-info">검색</button>
			</div>
			<div style="padding: 1px;"> </div>
		</div>
		<table id="qnatable" class="table table-hover"
			style="margin-left: auto; margin-right: auto; max-width: 70%; margin-bottom: 500p;">
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">답변 여부</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach items="${list}" var="list">
					<!-- 자신이 작성한 글만 보이도록 관리자는 모든 글 조회 가능 -->
					<c:if test="${user_id == list.user_id || user_id eq 'admin'}">
					<tr>
						<!-- 글 번호 출력 -->
						<td scope="row">${list.q_seq }</td>
						<!-- 글 제목 출력 -->
						<th><a href="questionContentView.do?q_seq=${list.q_seq }">${list.q_title }</a></th>
						<!-- 글 작성자 출력 -->
						<td>${list.user_nick }</td>
						<!-- 글 작성일자 출력 -->
						<td>${list.q_date }</td>
						
						<!-- 답변 여부 출력 -->
						<!-- 답변이 달려있다면 답변 완료, 달려있지 않다면 조금 더 기다려주세요 출력 -->
						<!-- 1. 답변이 없다면 -->
						<c:if test="${list.q_answer == null }">
							<!-- if 1. 사이트 이용자일 때 -->
							<c:if test="${user_id == list.user_id}">
								<td>조금만 더 기다려주세요.</td>
							</c:if>
							<!-- if 2. 사이트 관리자일 때 -->
							<c:if test="${user_id eq 'admin'}">
								<td>답변을 기다리고 있습니다.</td>
							</c:if>
						</c:if>
						<!-- 답변이 있다면 -->
						<c:if test="${list.q_answer != null }">
							<td>답변완료!!</td>
						</c:if>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

		<!-- 게시판 페이징 -->      
      <ul class="btn-group pagination " style="margin-left: 45%">
         <!-- 이전 버튼 생성 여부 확인, 버튼 보여주기 -->
         <c:if test="${pageMaker.prev}">
            <li>
               <a href='/qnaBoard.do?page=${pageMaker.startPage - 1}'><i class="fa fa-chevron-left"></i></a>
            </li>
         </c:if>
         
         <!-- 페이지의 시작 번호와 끝 번호 이용해 페이지 버튼 뿌려주기 -->
         <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
            <li>
               <a href="/qnaBoard.do?page=${pageNum}"><i class="fa">${pageNum}</i></a>
            </li>
         </c:forEach>
         
         <!-- 다음 버튼 생성 여부 확인, 버튼 보여주기 -->
         <!-- test에 추가해야함 pageMaker.endPage > 0 -->
         <c:if test="${pageMaker.next}">
            <li>
               <a href='/qnaBoard.do?page=${pageMaker.endPage + 1}'><i class="fa fa-chevron-right"></i></a>
            </li>
         </c:if>
      </ul>      


		<!-- 로그인 한 사용자에게만 글 작성 버튼 활성화 -->
		<%
		if (result != null) {
		%>
		<button style="margin-left: 29%;"
			onclick="window.location.href='qnaWriteForm.do?user_id=${result}'"
			class="btn btn-sm btn-success">글작성</button>
		<%
		}
		%>

	</div>
	<!--Start of footer-->
		<section id="footer" bottom: 0px; left: 0px; right: 0px">
	</section>
	<!--End of footer-->
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/js/footer.js"></script>	

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<!-- <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>-->
	<script src="js/jquery-1.12.3.min.js"></script>

	<!--Counter UP Waypoint-->
	<script src="js/waypoints.min.js"></script>
	<!--Counter UP-->
	<script src="js/jquery.counterup.min.js"></script>

	<!--Isotope-->
	<script src="js/isotope/min/scripts-min.js"></script>
	<script src="js/isotope/cells-by-row.js"></script>
	<script src="js/isotope/isotope.pkgd.min.js"></script>
	<script src="js/isotope/packery-mode.pkgd.min.js"></script>
	<script src="js/isotope/scripts.js"></script>


	<!--Back To Top-->
	<script src="js/backtotop.js"></script>


	<!--JQuery Click to Scroll down with Menu-->
	<script src="js/jquery.localScroll.min.js"></script>
	<script src="js/jquery.scrollTo.min.js"></script>
	<!--WOW With Animation-->
	<script src="js/wow.min.js"></script>
	<!--WOW Activated-->
	<script>
		new WOW().init();
	</script>


	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Custom JavaScript-->
	<script src="js/main.js"></script>
	<script src="js/search.js"></script>
</body>
</html>