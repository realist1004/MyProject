<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Blog</title>
<style type="text/css">
			li {list-style: none;  padding: 6px; display: inline-block;} 
			ul{ text-align: center;}
</style>
<!-- jquery 최신버전  -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 <!-- Font Awesome icons -->
<script src="https://kit.fontawesome.com/ac54200624.js" crossorigin="anonymous"></script>
</head>
<body>

<%@include file="header.jsp" %>
	   
	   <!-- 메인 -->
<div class="container">	  
	  <!--게시판 화면  -->
	
	 		  
	  <br /><br />
	  <div >
				<%@include file="nav.jsp" %>
		</div>
		<br />
	<section id="container">
	  <table class="table table-hover">
	     <tr>
	        <th>글번호</th> <th>글제목</th>
	        <th>조회수</th> <th>등록일</th>
	     </tr>
	     <c:set var="list" value="${list }" />
	     <c:if test="${!empty list }">
	        <c:forEach items="${list }" var="dto">
	          <tr>
	             <td> ${dto.board_no } </td>
	             <td> <a href="/board_cont.do?board_no=${dto.board_no}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">
	             		<c:out value="${dto.board_title}" /></a></td>       
	             <td> ${dto.board_hit } </td>
	             <td> ${dto.board_regdate.substring(0,10) } </td>
	          </tr>
	        </c:forEach>
	     </c:if>
	     <c:if test="${empty list }">
	     	<tr>
	     	   <td colspan="4" align="center">
	     	      <h3>검색된 레코드가 없습니다.</h3>
	     	   </td>
	     	</tr>
	     </c:if>
	     
	     <tr>
	        <td colspan="4" align="right">
	           <input type="button" value="글쓰기"
	                onclick="location.href='<%=request.getContextPath() %>/board_write.do'">
	     	</td>
	     </tr>
	  </table>
	  <!-- 검색단 -->
		<div class="search row">
			<div class="col-xs 2 col-sm-2">
			<select name="searchType" class="form-control">
				<option value="n"
					<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
				<option value="t"
					<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option> <!--eq(==)  -->
				<option value="c"
					<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				<option value="w"
					<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
				<option value="tc"
					<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			</select> 
			</div>
			<div class="col-xs-10 col-sm-10">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
					<span class="input-group-btn">
						<button id="searchBtn" type="button" class="btn btn-default">검색</button> 	
					</span>
				</div>
			</div>
			
			<script>
    		  $(function(){
      		 	 $('#searchBtn').click(function() { // /board로 searchType과 keyword값을 보낸다. makeQuery(1)로 기본설정함.
         			 self.location = "/board" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
       		 });
      });   
    		</script>
    		
		</div>
		<!-- 페이징단 -->
		<div class="col-md-offset-3">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li><a
						href="/board${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li><!--/ 이건 @RequestMapping("/") 이라서 써줌  -->
				</c:if>

				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="idx">
					<li><a href="/board${pageMaker.makeSearch(idx)}">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a
						href="/board${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>
		</section>
		
	</div>
	<!-- 메인 게시판화면 end -->
<%@include file="footer.jsp" %>	    
	  	 

	
</body>
</html>