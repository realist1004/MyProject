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
<!--crud 먼저 적용하기, 구글링, 학습자료 참고하기 -->

	<!--header부분  -->
	<header>	
	   <nav class="navbar navbar-inverse">
	      <div class="container-fluid">
	        <div class="navbar-header">
	        	<!-- 모바일용 일때 오른쪽 메뉴바 -->
	        	<button type="button" class="collapsed navbar-toggle"
	        	        data-toggle="collapse" data-target="#nav_menu"
	        	        aria-expaned="false">
	        	  <span class="sr-only">Toggle Navigation</span>
	        	  <span class="icon-bar"></span>
	        	  <span class="icon-bar"></span>
	        	  <span class="icon-bar"></span>
	        	</button>
	        
	           <a class="navbar-brand" href="#">My Blog</a>
	        </div>
	        <div class="collapse navbar-collapse" id="nav_menu">
	           <ul class="nav navbar-nav">
	              <li> <a href="#">Category</a> </li>
	              <li> <a href="#">Tags</a> </li>
	              <li> <a href="#">Year</a> </li>
	              <li> <a href="#">login</a> </li>
	           </ul>
	           <form class="navbar-form navbar-right" role="search">
        		<div class="form-group">
          		<input type="text" class="form-control" placeholder="Search">
        		</div>
        		<button type="submit" class="btn btn-default">Submit</button>
      		</form>
	        </div>	      
	      </div>	 
	   </nav>		     
	  </header>
	   
	   <!-- 메인 -->
	   <div class="container">
	   <h1>최근 포스트</h1>
	   <!--게시판 화면  -->
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
	<!-- 메인 게시판화면 end -->
	   </div>
	  	 
	    <!-- Footer부분 -->
        <footer class="container-fluid navbar-fixed-bottom">          
                        <ul class="list-inline text-center">
                            <li class="list-inline-item">
                                <a href="#!">
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-twitter fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#!">                               
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#!">
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-github fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                        <div class="small text-center text-muted fst-italic">wnfkrlthsus &copy; naver.com</div>            
        </footer>
	
</body>
</html>