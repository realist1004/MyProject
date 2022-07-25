<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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
		
				location.href = "/board?page=${scri.page}"
								+"&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
				})
				
		$(".replyWriteBtn").on("click", function(){
			  var formObj = $("form[name='replyForm']");
			  formObj.attr("action", "/replyWrite");
			  formObj.submit();
			});
		//댓글 수정 View
		$(".replyUpdateBtn").on("click", function(){
			location.href = "/replyUpdateView?board_no=${cont.board_no}"
							+ "&page=${scri.page}"
							+ "&perPageNum=${scri.perPageNum}"
							+ "&searchType=${scri.searchType}"
							+ "&keyword=${scri.keyword}"
							+ "&rno="+$(this).attr("data-rno");
		});
				
		//댓글 삭제 View
		$(".replyDeleteBtn").on("click", function(){
			location.href = "/replyDeleteView?board_no=${cont.board_no}"
				+ "&page=${scri.page}"
				+ "&perPageNum=${scri.perPageNum}"
				+ "&searchType=${scri.searchType}"
				+ "&keyword=${scri.keyword}"
				+ "&rno="+$(this).attr("data-rno");
		});

	})
	function fn_fileDown(fileNo){
		var formObj = $("form[name='readForm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "/fileDown");
		formObj.submit();
	}
</script>

<body>
<%@include file="header.jsp" %>

	<div class="container">
		
	   <div>
				<%@include file="nav.jsp" %>
		</div>
		<br />
		
	<section id="container">
	   <form name="readForm" role="form" method="post"><!-- name=""이 dto 이름과 같아야함. -->
			<input type="hidden" id="board_no" name="board_no" value="${cont.board_no}" /><!--${cont.getBoard_no()} 써도 똑같음  -->
 			<input type="hidden" id="page" name="page" value="${scri.page}"> 
 			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
  			<input type="hidden" id="FILE_NO" name="FILE_NO" value=""> 
			
		</form>
	   <table class="table table-borderless">
	   <c:set var="dto" value="${cont }"></c:set>
	   <c:if test="${!empty dto }">	      
	      	 <tr >
	      	    <th colspan="2" align="left">
	      	      <h4>${dto.board_no } 님 게시물 상세 내역</h4>
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
	      	 	   <textarea rows="8" cols="30" readonly class="form-control">${dto.board_cont } </textarea>
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
	    	 <tr>
	      	 	<th>파일 목록</th>
	      	 	<td>
	      	 	 	<c:forEach var="file" items="${file }"> 
	      	 	 		<!-- a태그를 클릭하면 해당 href로 이동하지만 onclick을 먼저 수행하고 href로 이동함, onclick에 return false가 있을 경우 href를 수행하지 않음-->
	      	 	 		<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME }</a>(${file.FILE_SIZE}kb)<br/>
	      	 	 	</c:forEach>
	      	 	</td>
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
	      		<button type="submit" class="update_btn btn btn-warning">수정</button>
	            &nbsp;&nbsp;&nbsp;
	            <button type="submit" class="delete_btn btn btn-danger">삭제</button>
	            &nbsp;&nbsp;&nbsp;
	            <button type="submit" class="list_btn btn btn-primary">목록</button>      	             					 	  
	      	</td>
	      </tr>
	   </table>
	   
	   <!-- 댓글 -->
		<div id="reply">
		  <ol class="replyList">
		    <c:forEach items="${replyList}" var="replyList">
		      <li>
		        <p>
		        작성자 : ${replyList.writer}<br />
		        작성 날짜 :  <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" />
		        </p>
		
		        <p>${replyList.content}</p>
		        <div>
				  <button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno}">수정</button>
				  <button type="button" class="replyDeleteBtn btn btn-danger" data-rno="${replyList.rno}">삭제</button>
				</div>
		      </li>
		    </c:forEach>   
		  </ol>
		</div>
		
		<form name="replyForm" method="post" class="form-horizotal">
		  <input type="hidden" id="board_no" name="board_no" value="${cont.board_no}" />
		  <input type="hidden" id="page" name="page" value="${scri.page}"> 
		  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		
		  <div class="form-group">
			    <label for="writer" class="col-sm-2 control-label">댓글 작성자</label>
			    <div class="col-sm-10">
			    	<input type="text" id="writer" name="writer" class="form-control"/>
			    </div>			    
		  </div>
		  <div class="form-group">
			    <label for="content" class="col-sm-2 control-label">댓글 내용</label>
			    <div class="col-sm-10">
			    	<input type="text" id="content" name="content" class="form-control"/>
			    </div>			    
		  </div>
		  <div class="form-group">
		  	<div class="col-sm-offset-2 col-sm-10">
		 	 <button type="button" class="replyWriteBtn btn btn-success" >작성</button> <!-- 풋터화면안으로 들어가서 작동이안됨 수정해야함 -->
		 	 </div>
		  </div>		  
		</form>
		</section>
	</div>
	
	
<%@include file="footer.jsp" %> 
</body>
</html>