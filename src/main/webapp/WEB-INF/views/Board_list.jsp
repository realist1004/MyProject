<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
			li {list-style: none;  padding: 6px; display: inline-block;} 
			ul{ text-align: center;}
</style>
</head>
<body>
	<div align="center">
	 
	  
	
	  <hr width="50%" color="red">
	     <h3>MVC-2 모델 BOARD1 테이블 전체 리스트</h3>
	  <hr width="50%" color="red">
	  <br /><br />
	  <div >
				<%@include file="nav.jsp" %>
		</div>
		<br />
	  <table>
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
		<div class="search">
			<select name="searchType">
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
			</select> <input type="text" name="keyword" id="keywordInput"
				value="${scri.keyword}" />

			<button id="searchBtn" type="button">검색</button>
			<script>
    		  $(function(){
      		 	 $('#searchBtn').click(function() { // Board_list.do로 searchType과 keyword값을 보낸다. makeQuery(1)로 기본설정함.
         			 self.location = "Board_list.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
       		 });
      });   
    		</script>
		</div>
		<!-- 페이징단 -->
		<div >
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a
						href="Board_list.do${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="idx">
					<li><a href="Board_list.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a
						href="Board_list.do${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html> --%>