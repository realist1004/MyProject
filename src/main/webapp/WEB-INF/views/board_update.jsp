<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board_cont.do?board_no=${update.board_no}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
						
			$(".update_btn").on("click", function(){
				if(fn_valiChk()){// fn_valiChk()의 if문을 실행할 경우 return true 값을 주고
					return false; // 유효성 검사로 입력란에 값이 없으면 false로 submit하지않는다.
				}				
				formObj.attr("action", "/updateOk.do");
				formObj.attr("method", "post");
				formObj.submit();
			})
		})
			
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
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
		//삭제버튼을 눌렀을때 파일의 번호와 파일의 인덱스를 파라미터로 fn_del()함수에 보내줍니다.
		//push를 이용하여 삭제한 번호를 담아줍니다. 담은 파일을 input태그에 값을 담아줍니다.
		var fileNoArry = new Array();
		var fileNameArry = new Array();
		function fn_del(value, name){
			fileNoArry.push(value);
			fileNameArry.push(name);
			$("#fileNoDel").attr("value", fileNoArry);
			$("#fileNameDel").attr("value", fileNameArry);
		}
		
	</script>
<body>
<%@include file="header.jsp" %>
	<div align="center">
	   <hr width="50%" color="skyblue">	
	      <h3>BOARD1 테이블에 게시물 수정 폼</h3>
	   <hr width="50%" color="skyblue">
	   <br />
	   <div>
				<%@include file="nav.jsp" %>
		</div>
		<br />
	   <form name="updateForm" method="post" action="/updateOk.do" enctype="multipart/form-data">
	    <c:set var="dto" value="${update }"></c:set>	   
	      <%-- type="hidden" : <form> 태그에는 보이지 않고 데이터를 서블릿으로 전송하는 속성 --%>
	      	<input type="hidden" name="board_no" value="${dto.getBoard_no() }">
	      	<input type="hidden" id="page" name="page" value="${scri.page}"> 
 			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
	      	<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
			<input type="hidden" id="fileNameDel" name="fileNameDel[]" value=""> 
	      <table border="1" cellspacing="0" width="400">
	      	 <c:if test="${!empty dto }">
	         <tr>
	            <th>작성자</th>
	         	<td> <input type="text" name="board_writer"
	         				value="${dto.getBoard_writer() }" readonly /> </td>
	         </tr>
	         <tr>
	         	<th>글제목</th>
	         	<td> <input type="text" name="board_title"
	         				value="${dto.getBoard_title() }" class="chk" title="제목을 입력하세요."/> </td>
	         </tr>
	         <tr>
	         	<th>글내용</th>
	         	<td>
	         	   <textarea rows="7" cols="30" name="board_cont" class="chk" title="글내용을 입력하세요.">${dto.getBoard_cont() }
	         	   </textarea>
	         	</td>
	         </tr>
	         <tr>
	         	<th>비밀번호</th>
	         	<td> <input type="password" name="board_pwd" value="${dto.getBoard_pwd() }" class="chk" title="비밀번호를 입력하세요."/></td>
	         </tr>
	       	</c:if>
				<tr>
					<td id="fileIndex">
						<c:forEach var="file" items="${file }" varStatus="var">
							<div>
								<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index }" value="${file.FILE_NO }">
								<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index }">
								<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME }</a>(${file.FILE_SIZE}kb)
								<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index }');" type="button">삭제</button>
							</div>
						</c:forEach>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<button type="button" class="update_btn">글수정</button>&nbsp;&nbsp;
						<button type="button" class="cancel_btn">취소</button>
						<button type="button" class="fileAdd_btn">파일추가</button>
					</td>
				</tr>
			</table>
	   </form>
	</div>
<%@include file="footer.jsp" %>
</body>
</html>