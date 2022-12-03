<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="total_qna" value="${qnaMap.total_qna }" />
<c:set var="qna_list" value="${qnaMap.qna_list}" />
<c:set var="reply_list" value="${qnaMap.reply_list}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<script>
	let current_page = 1; // 현재 페이지
	$(function(){
		let now = new Date();
		let ago = new Date(now.setDate(now.getDate()-365));
		let today = date_setting(now);
		let year = date_setting(ago);
		
		$('input[name=startDate]').attr('min',year);
		$('input[name=endDate]').attr('max',today);
		$('input[name=startDate]').val(today);
		$('input[name=endDate]').val(today);
		
		checkbox_setting();
		
		paging_set();
		
		let reply_modal = $('.reply_modal');
		let reply_open = $('#reply_btn');
		
		$('#reply_btn').click(function(){
			$('.reply_modal').css("display","block");
			$('body').css("overflow","hidden");
		});
		
		$('#reply_close_btn').click(function(){
			$('.reply_modal').css("display","none");
			$('body').css("overflow","unset");
		});
		
	});
	
	function get_page(){
		let list_day = $('#list_day').val();
		let list_count = $('#list_count').val();
		/* let start_date = $('input[name=startDate]').val();
		let end_date = $('input[name=endDate]').val(); */
		
		location.href="${path}/board/qna_list";
		
		/* $.ajax({
			url:${path}+'/board/qna_list',
			dataType:'text',
			contentType : "application/json",
			data:JSON.stringify{
				'current_page' : current_page,
				'list_count' : list_count,
				'list_day' : list_day
			},
			success:function(data){
				alert('해치웠나?');
			}
		}); */
	}
	
	function paging_set(){
		let list_count = $('#list_count').val();
		let total_qna = ${total_qna};
		
		let total = (total_qna / list_count) + 1;
		$('.list_paging').append('<button id="prev"><i class="fa-solid fa-angle-left"></i></button>');
		for(let i=1; i<total; i++){
			$('.list_paging').append('<button id="page" onclick="page_go(this)">'+i+'</button>');
		}
		$('.list_paging').append('<button id="prev"><i class="fa-solid fa-angle-right"></i></button>');
	}
	
		// 최근등록일
		// 오래된 순
		// 검색 조건에 따른 검색
		// 20개씩
		// 50개씩
	
	function page_go(obj){
		let button = $(obj).text();
		console.log(button);
	}
	
	function checkbox_setting(){
		$('input[type="checkbox"][name="status"]').click(function(){
			if($(this).prop('checked')){
				$('input[type="checkbox"][name="status"]').prop('checked',false);
				$(this).prop('checked',true);
			}
		});
	}
		
	function getDay(obj){
		let today = new Date();
		let select_date = $(obj).attr('id');
		
		switch(select_date){
		case 'today': today = new Date(); break;
		case 'week': today = new Date(today.setDate(today.getDate()-7)); break;
		case '1month': today = new Date(today.setMonth(today.getMonth()-1)); break;
		case '3month': today = new Date(today.setMonth(today.getMonth()-3)); break;
		}
		
		date = date_setting(today);
		
		$('input[name=startDate]').val(date);
	}
	 
	 function date_setting(today){
		let day = today.getDate();
		let month = today.getMonth()+1;
		let year = today.getFullYear();
		if(day < 10) day = '0'+day;
		if(month < 10) month = '0'+month;
		today = year + '-' + month + '-' + day;
		return today;
	 }
	 
	 function modal_set(){
			let reply_modal_btn = document.querySelect('#reply_btn');
			let reply = document.querySelect('.reply');
			reply_modal_btn.addEventListener('click', function(){
				reply.css("display","block");
			});
		}
	 
</script>
<style>
	@import url("https://fonts.google.com/noto/specimen/Noto+Sans+KR/about?query=noto#supported-writing-systems");
	*{margin:0; padding:0; font-family: Noto Sans Korean;}
	.qna_list{margin:45px auto; width:1200px; background-color: #EDF0F5; padding-top: 10px;}
	.qna_list_header{margin-left:10px;height:60px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	.qna_list_header_title{margin-left:10px; padding-top:10px;}
	.qna_list_search{margin-top: 10px;margin-left:10px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	.qna_search_table{width:100%;}
	.qna_search_title{padding-left:20px; width:20%; height:50px;}
	.qna_search_date{width:80%; display: flex; margin-top:5px;}
	.date_btn{width:60px; font-size: small; height: 35px; border:1px solid #474948; background-color: #F8F9FD; color:black; margin-right: 5px;}
	.date_btn:hover{background-color:#474948; color:white;}
	input[type=date] {width:150px; text-align: center; font-weight: bold;}
	input[type=checkbox] {transform:scale(1.3);}
	.qna_search_detail{height:50px;}
	select{width:100px; height:35px;}
	#keyword {width:480px; height:35px;}
	.qna_search_button input{margin-bottom: 0px;}
	#qna_search_btn {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	#search_reset {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large; margin-right:100px;}
	.qna_list_body_header{margin-left:10px; height:60px; margin-top:20px; display: flex; justify-content: space-between;}
	.body_header_one{display:flex; padding-top:25px;}
	.body_header_two{margin-right:10px;padding-top:15px;}
	.body_header_two>select {width:110px;}
	.qna_list_body_content{margin-left:10px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	
	.list_header{display:flex; justify-content:space-between; height:50px; border-bottom: 2px solid #A6A7AB; background-color: #F8F9FD;}
	.list_header span{text-align: center; font-weight: bold; padding-top:13px; margin-right:10px;}
	.list_content {min-height:50px;}
	.list_content span{margin-top:13px; margin-right:10px;}
	summary{display: flex; justify-content: space-between; text-align: center; min-height:50px;}
	#num{width:5%; text-align: center;}
	#product{width:15%; overflow: hidden; white-space: nowrap; text-align: center;}
	.list_content #product {font-size: small; white-space: nowrap; text-align: center; display: block;}
	#title{width:40%;}
	#writer{width:10%; text-align: center;}
	#date{width:10%; text-align: center;}
	#status{width:10%; text-align: center;}
	#delete{width:10%; text-align: center; margin-right:0;}
	summary>#title{text-align: left;}
	.content_inner{border-top:1px solid #A6A7AB; border-bottom:1px solid #A6A7AB; background-color: #F7F8FA; padding-left: 100px;}
	.user_content{min-height: 50px; display: flex;}
	.reply_content{display: flex; min-height: 50px; justify-content: space-between;}
	#reply_front{color:#525253; width:20px;}
	#reply_second{background-color:#525253; color:white; border-radius: 3px; height:100%; width:35px;}
	#reply_content{width:795px; border-bottom:1px solid #A6A7AB;}
	#reply_btn, #delete_btn {height: 30px; border-radius: 2px; border:1px solid #474948; cursor: pointer; width:75px; background-color: #F8F9FD;}
	#reply_btn:hover, #delete_btn:hover {background-color: #474948; color:white;}
	
	.qna_list_footer{margin:20px auto; margin-left:10px;}
	.list_paging{height: 50px; display: flex; justify-content: space-between; padding: 0 475px;}
	.list_paging>button {width:25px; height:25px; border:0; background-color: transparent; cursor: pointer;}
	.list_paging>button:hover {background-color: #474948; border-radius: 50%; color:white;}
	.list_paging>#prev,#next {background-color: #474948; border-radius: 50%; color:white;}
	
	.reply_modal {display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); 
		background-color: rgba(0,0,0,0.4);}
	.reply_modal-content {width: 800px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;}
</style>
</head>
<body>
	<div class="qna_list">
		<div class="qna_list_header">
			<div class="qna_list_header_title"><h2>문의글 관리</h2></div>
		</div>
		
		<div class="qna_list_search">
			<table class="qna_search_table">
				<tr>
					<td class="qna_search_title">작성일</td>
					<td class="qna_search_date">
						<input type="date" name="startDate" max="" min=""/>&nbsp;~
						<input type="date" name="endDate" max="" min=""/>&nbsp;&nbsp;
						<button class="date_btn" id="today" onclick="getDay(this)">오늘</button>
						<button class="date_btn" id="week" onclick="getDay(this)">1주일</button>
						<button class="date_btn" id="1month" onclick="getDay(this)">1개월</button>
						<button class="date_btn" id="3month" onclick="getDay(this)">3개월</button>
					</td>
				</tr>
				<tr>
					<td class="qna_search_title">답변구분</td>
					<td class="qna_search_status">
						<input type="checkbox" id="reply_on" name="status" value="0"/>
						<label for="reply_on">답변대기</label>&nbsp;&nbsp;
						<input type="checkbox" id="reply_off" name="status" value="1"/>
						<label for="reply_off">답변완료</label>
						
					</td>
				</tr>
				<tr>
					<td class="qna_search_title">상세구분</td>
					<td class="qna_search_detail">
						<select name="keyword_set">
							<option>검색조건</option>
							<option value="title">글제목</option>
							<option value="qna_writeId">작성자</option>
							<option value="product_name">상품명</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요."/>
					</td>
				</tr>
				<tr>
					<td class="qna_search_button" colspan="2" style="text-align: center; height:100px;">
						<input type="button" id="search_reset" onclick="" value="취소"/>
						<input type="button" id="qna_search_btn" onclick="" value="검색"/>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="qna_list_body">
			<div class="qna_list_body_header">
				<div class="body_header_one">
					<div class="qna_list_body_header_title"><h4>문의글 목록&nbsp;&nbsp;</h4></div>(총&nbsp;<font color="blue">${total_qna}</font>개&nbsp;)
				</div>
				<div class="body_header_two">
					<select name="list_day" id="list_day">
						<option value="desc">최근등록일순</option>
						<option value="asc">등록일순</option>
					</select>
				
					<select name="list_count" id="list_count">
						<option value="20">20개씩</option>
						<option value="50">50개씩</option>
					</select>
				</div>
			</div>
			
			<div class="qna_list_body_content">
				<div class="list_header">
					<span id="num">번호</span>
					<span id="product">상품명</span>
					<span id="title">제목</span>
					<span id="writer">작성자</span>
					<span id="date">작성일</span>
					<span id="status">답변상태</span>
					<span id="delete">삭제</span>
				</div>
				<c:if test="${empty qna_list}">
				<div class="list_content" style="border-bottom: 1px solid #A6A7AB; display: block;">
					<p id="empty_content" align="center" style="padding-top:13px;">작성된 문의가 없습니다.</p>
				</div>
				</c:if>
				<c:if test="${not empty qna_list}"></c:if>
				<div class="list_content">
				<c:forEach var="qna" items="${qna_list}" varStatus="qna_num">
					<details>
						<summary>
							<span id="num">${total_qna - qna_num.index}</span>
							<span id="product">${qna.product_name}</span>
							<span id="title">&nbsp;&nbsp;${qna.qna_title}</span>
							<span id="writer">${qna.qna_writeId}</span>
							<span id="date">${qna.qna_regDate}</span>
							<c:if test="${qna.qna_status == 0}">
								<span id="status"><button id="reply_btn">답변하기</button></span>
							</c:if>
							<c:if test="${qna.qna_status == 1}">
								<span id="status">답변완료</span>
							</c:if>
							<span id="delete"><button id="delete_btn">삭제</button></span>
						</summary>
							<div class="content_inner">
								<div class="user_content">
									<span id="content">${qna.qna_content}</span>
								</div>
								<c:forEach var="reply" items="${reply_list}">
									<c:if test="${reply.qna_parentId == qna.qna_id}">
										<div class="reply_content">
											<span id="reply_front">└</span>
											<span id="reply_second">답변</span>
											<span id="reply_content">${reply.qna_content}</span>
											<span id="date" >${reply.qna_regDate}</span>
											<span id="writer">관리자</span>
										</div>
									</c:if>
								</c:forEach>
							</div>
					</details>
					
					<!-- Modal의 내용 -->
					<div class="reply_modal"> 
						<div class="reply_modal-content">             
							<c:import url="/board/reply">
								<c:param name="qna_id" value="${qna.qna_id}"></c:param>
							</c:import>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="qna_list_footer">
			<div class="list_paging"></div>
		</div>
	</div>
</body>
</html>