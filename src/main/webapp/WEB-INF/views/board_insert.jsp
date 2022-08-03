<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>게시판 글 작성</title>
</head>
<script type="text/javascript">
	 	$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board_writeOk.do");
				formObj.attr("method", "post");
				formObj.submit();
			});
			
			fn_addFile();
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	 	function fn_addFile(){
	 		var fileIndex = 1;
	 		//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
	 		$(".fileAdd_btn").on("click", function(){
	 			$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");	
	 		});
	 		$(document).on("click", "#fileDelBtn", function(){
	 			$(this).parent().remove();
	 		});
	 	}
	 	
	</script>

<body>
<%@include file="header.jsp" %>
<div align="center">
	   <hr width="50%" color="skyblue">
	      <h3>BOARD 테이블에 게시물 글쓰기 폼</h3>
	   <hr width="50%" color="skyblue">
	   <br />
	   <div>
				<%@include file="nav.jsp" %>
		</div>
		<br />
	<section id="container">
	   <form name="writeForm" method="post" action="/board_writeOk.do" enctype="multipart/form-data">
	      <table border="1" cellspacing="0" width="400">
	      	<tbody>
	      		<c:if test="${member.userId != null }">
	         <tr>
	            <th>작성자</th>
	         	<td> <input type="text"  name="board_writer" class="chk" title="작성자를 입력하세요." /> </td>
	         </tr>
	         <tr>
	         	<th>글제목</th>
	         	<td> <input type="text"  name="board_title" class="chk" title="글제목을 입력하세요."/> </td>
	         </tr>
	         <tr>
	         	<th>글내용</th>
	         	<td>
	         	   <textarea rows="7" cols="30"  name="board_cont" class="chk" title="글내용을 입력하세요."></textarea>
	         	</td>
	         </tr>	         	         
	         <tr>
	         	<th>비밀번호</th>
	         	<td> <input type="password"  name="board_pwd" class="chk" title="비밀번호를 입력하세요."/> </td>
	         </tr>
	         <tr>
	         <tr>
	         	<td id="fileIndex"></td>
	         </tr>
	         <tr>
	         	<td colspan="2" align="center">
	         	   <button class="write_btn" type="submit">작성</button>&nbsp;&nbsp;
	         	   <input type="reset" value="취소" />
	         	   <button class="fileAdd_btn" type="button">파일추가</button>
	         	</td>
	         </tr>
	         </c:if>
	         <c:if test="${member.userId == null }">
	         	<p>로그인 후에 작성하실 수 있습니다.</p>
	         </c:if>	
	         </tbody>
	      </table>
	   </form>
	   </section>
	</div>
<%@include file="footer.jsp" %>
</body>
</html>