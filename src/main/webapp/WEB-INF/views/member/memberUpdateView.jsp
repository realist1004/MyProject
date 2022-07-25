<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery 최신버전  -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>회원가입</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		//취소
		$(".cencle").on("click", function(){
			location.href="/";
		})
		$("#submit").on("click", function(){
			if($("#userPass").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			if($("#userName").val()==""){
				alert("성명을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			$.ajax({
				url : "/member/passChk",
				type : "POST",
				dataType : "json",
				data : $("#updateForm").serializeArray(),
				success : function(data){
					if(data == true){
						if(confirm("회원수정하시겠습니까?")){
							$("#updateForm").submit();
						}
					}else{
						alert("패스워드가 틀렸습니다.");
						return;
					}
				}
			})
		});
	})	
</script>
<body>
	<section id="container">
		<form action="/member/memberUpdate" method="post" id="updateForm">
			<div class="form-group has-feedback">
				<label class="control-label" for="userId">아이디</label>
				<input class="form-control" type="text" id="userId" name="userId" value="${member.userId }" readonly="readonly"/>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userPass">패스워드</label>
				<input class="form-control" type="password" id="userPass" name="userPass" value="${member.userPass }" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userName">성명</label>
				<input class="form-control" type="text" id="userName" name="userName" value="${member.userName }" />
			</div>
		</form>
			<div class="form-group has-feedback">
				<button class="btn btn-success" type="button" id="submit">회원정보수정</button>
				<button class="cencle btn btn-danger" type="button">취소</button>
			</div>
		
	</section>
</body>
</html>