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


	$(document).ready(function() {
		var formObj = $("form[name='readForm']");
		
		
		// 수정 
		$(".update_btn").on("click", function(){
			formObj.attr("action", "/board_update.do");
			formObj.attr("method", "get");
			formObj.submit();				
		})
		
		
		// 삭제
		$(".delete_btn").on("click", function(){
				
				var deleteYN = confirm("삭제하시겠습니가?");
				if(deleteYN == true){
					
				formObj.attr("action", "/board_delete.do");
				formObj.attr("method", "post");
				formObj.submit();
					
				}
			})
		// 목록
		$(".list_btn").on("click", function(){
		
				location.href = "/?page=${scri.page}"
								+"&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
				})	

	})
</script>

<body>
	<div align="center">
		<hr width="500" color="tomato">
	      <h3>Board 테이블 사원 상세 내역</h3>
	   <hr width="500" color="tomato">
	   <br /><br />
	   <div>
				<%@include file="nav.jsp" %>
		</div>
		<br />
	   <form name="readForm" role="form" method="post">
			<input type="hidden" id="board_no" name="board_no" value="${cont.board_no}" /><!--${cont.getBoard_no()} 써도 똑같음  -->
 			<input type="hidden" id="page" name="page" value="${scri.page}"> 
 			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		</form>
	   <table border="1" cellspacing="0" width="400">
	   <c:set var="dto" value="${cont }"></c:set>
	   <c:if test="${!empty dto }">	      
	      	 <tr>
	      	    <th colspan="2" align="center">
	      	      <h3>${dto.board_no } 님 게시물 상세 내역</h3>
	      	 	</th>
	      	 </tr>
	      	 <tr>
	      	 	<th>작성자</th>
	      	 	<td>${dto.board_writer } </td>
	      	 </tr>
	      	 <tr>
	      	 	<th>글제목</th>
	      	 	<td>${dto.board_title }  </td>
	      	 </tr>
	      	 <tr>
	      	 	<th>글내용</th>
	      	 	<td>
	      	 	   <textarea rows="8" cols="30" readonly>${dto.board_cont } </textarea>
	      	 	</td>
	      	 </tr>
	      	 <tr>
	      	 	<th>조회수</th>
	      	 	<td>${dto.board_hit } </td>
	      	 </tr>
	      	 <tr>
	      	 	<th>작성일자</th>
	      	 	<td>${dto.board_regdate }  </td>
	      	 </tr>
	    
	      </c:if>
	      <c:if test="${empty dto }">
	    	  <tr>
	    	  	<td colspan="2" align="center">
	    	  		<h3>검색된 레코드가 없습니다.</h3>
	    	  	</td>
	    	  </tr> 
	      <tr>
	      </c:if>
	      <tr>
	      	<td colspan="2" align="right">
	      		<button type="submit" class="update_btn">수정</button>
	            &nbsp;&nbsp;&nbsp;
	            <button type="submit" class="delete_btn">삭제</button>
	            &nbsp;&nbsp;&nbsp;
	            <button type="submit" class="list_btn">목록</button>      	             					 	  
	      	</td>
	      </tr>
	   </table>
	</div>
</body>
</html>