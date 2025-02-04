<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/project/resources/common/css/top.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script type="text/javascript">


 $(document).ready(function() {
	 $("#itemcategory>li").each(function(){
		 $(this).click(function(){
			 category = $(this).text();
			 
			 $("#itemcategory>li").removeAttr("class");
			 $(this).attr("class","active");
			 $.ajax({
				url:"/project/store/ajax_storelist.do",
				type:"get",
				data:{"category":category},
				success:function(data){
					alert(data);
					viewdata ="";
					
					for(i=0; i<data.length; i++){
						alert(data[i].price);
						
						viewdata = viewdata + 
		"<div class='col-lg-4 col-md-6 mb-4'>"+
						"<div class='card h-100'>"+
		"<a href='/project/store/read.do?code="+data[i].code+"&state=READ'>"+
		"<img class='card-img-top' src='/project/resources/images/store/"+data[i].mainimg+"' alt=''></a>"+
							"<div class='card-body'>"+
								"<h4 class='card-title'>"+
									"<a href='/project/store/read.do?code=${store.code}&state=READ'>"+data[i].name+"</a></h4>"+
						"<h5>" +data[i].price+" 원</h5>	</div>	<br><br></div></div><div></div>	"								
					}
					$("#storedatalist").empty();
					$("#storedatalist").append(viewdata);
				},
				error:function(a,b,c){
					alert(c);
				}				 
			 })			 
		 });
		});
	 });
 
 function list(page){
	 location.href="/project/store.do?curPage="+page+"&searchOption-${map.searchOption}"+"&keyword=${map.keyword}";
	 
 }
</script>

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<h1 class="my-4">E-Store</h1>
				<div class="list-group">
					<ul class="nav" id="itemcategory">
					<li><a href="#" class="list-group-item">네덜란드</a></li>
					<li><a href="#" class="list-group-item">대한민국</a></li>
					<li><a href="#" class="list-group-item">독일</a></li>
					</ul>
				</div>
				<a href="/project/store/insert.do">등록하기</a>
			</div>
			<!-- /.col-lg-3 -->
			<div class="col-lg-9">

				<div class="row" align="center">

<h1>상품 리스트</h1>
		<br><br>
		<form action="/project/store.do" name="form1">
			<select name="searchOption">
				<option value="all" <c:out value="${map.searchOption == 'all'?'selected':'' }"/>> 전체검색 </option>
				<option value="name"<c:out value="${map.searchOption == 'name'?'selected':''}"/> >상풍명</option>
			</select>
			<input name="keyword" value="${map.keyword}">
			<input type="submit" value="조회">
			${map.count}개의 상품이 있습니다.						
		</form>
		<br><br>
		<span id="storedatalist">
		
					<c:forEach var="store" items="${map.list}">
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a href="/project/store/read.do?code=${store.code}&state=READ&curPage=${map.boardPager.curPage}"><img
									class="card-img-top"
									src="/project/resources/images/store/${store.mainimg}" alt=""></a>
								<div class="card-body">
									<h4 class="card-title">
										<a href="/project/store/read.do?code=${store.code}&state=READ">${store.name}</a>
									</h4>		
																
									<h5>${store.price}원</h5>
								</div>
								<br><br>
							</div>
						</div>
						<div></div>
					</c:forEach>
		</span>				
					<br>
					<div>
					
					<c:if test="${map.boardPager.curBlock > 1}">
					<a href="javascript:list('1')">[처음]</a>
				</c:if>
				
				<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.boardPager.curBlock > 1}">
					<a href="javascript:list('${map.boardPager.prevPage}')">[이전]</a>
				</c:if>
				
				<!-- **하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 -->
				<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
					<!-- 현재페이지이면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == map.boardPager.curPage}">
							<span style="color: red">${num}</span>&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
					<a href="javascript:list('${map.boardPager.nextPage}')">[다음]</a>
				</c:if>
				
				<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
					<a href="javascript:list('${map.boardPager.totPage}')">[끝]</a>
				</c:if>
					
					
					
					</div>

				</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>


</body>
</html>