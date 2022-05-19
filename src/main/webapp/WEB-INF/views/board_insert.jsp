<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>
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
	</script>

<body>
	<div align="center">
	   <hr width="50%" color="skyblue">
	      <h3>BOARD 테이블에 게시물 글쓰기 폼</h3>
	   <hr width="50%" color="skyblue">
	   <br />
	   <div>
				<%@include file="nav.jsp" %>
		</div>
		<br />
	   <form name="writeForm" method="post" action="/board_writeOk.do">
	      <table border="1" cellspacing="0" width="400">
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
	         	<td colspan="2" align="center">
	         	   <button class="write_btn" type="submit">작성</button>&nbsp;&nbsp;
	         	   <input type="reset" value="취소" />
	         	</td>
	         </tr>
	      </table>
	   </form>
	</div>
</body>
</html>