<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<form action="" method="">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><label class="form-text" for="input-uname">이름</label></th>
									<td><input id="input-uname" type="text" name="name"></td>
									<th><label class="form-text" for="input-pass">패스워드</label></th>
									<td><input id="input-pass" type="password" name="password"></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button type="submit">등록</button></td>
								</tr>
							</tbody>

						</table>
						<!-- //guestWrite -->

					</form>

					<div id="listArea"></div>

				</div>
				<!-- //guestbook -->

			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->

		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("data");
		
		fetchList()

	});

	function fetchList() {

		$.ajax({
			url : "${pageContext.request.contextPath}/api/guestbook/list",
			type : "post",
			//contentType: "application/json",
			//data : {name:”홍길동”},

			dataType : "json",
			success : function(guestList) {
				
				console.log(guestList)
				//성공시 처리해야 될 코드 작성
				for (var i = 0; i < guestList.length; i++) {
					render(guestList[i],"down");
				}

			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
		// ajax 
	};
	// function
	function render(guestbookVo,opt) {
		var str = '';
		str += '<table class="guestRead">';
		str += '<colgroup>               ';
		str += '<col style="width: 10%;">';
		str += '<col style="width: 40%;">';
		str += '<col style="width: 40%;">';
		str += '<col style="width: 10%;">';
		str += '</colgroup>';
		str += '<tr>';
		str += '<td>' + guestbookVo.no + '</td>';
		str += '<td>' + guestbookVo.name + '</td>';
		str += '<td>' + guestbookVo.regDate + '</td>';
		str += '<td><a href="">[삭제]</a></td';
		str += '</tr>';
		str += '<tr>';
		str += '<td colspan=4 class="text-left">' + guestbookVo.content + '</td>';
		str += '</tr>';
		str += '</table>';
		
		//리스트 순서
        if (opt == "down") {
            $("#listArea").append(str);

        } else if (opt == "up") {
            $("#listArea").prepend(str);

        } else {
            console.log("opt오류");
        }

	}
</script>

</html>