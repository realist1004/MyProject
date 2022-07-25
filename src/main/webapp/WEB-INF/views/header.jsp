<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</body>
</html>