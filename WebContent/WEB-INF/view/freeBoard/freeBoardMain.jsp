<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div id="searchBox">
		<select id="searchType" style="margin: 5px">
			<option value="0">전체</option>
			<option value="1">타입</option> <!-- selectbox -->
			<option value="2">번호</option> <!-- input type text 검색버튼 클릭시 숫자체크할것-->
			<option value="3">제목</option> <!-- input type text -->
			<option value="4">내용</option> <!-- input type text -->
			<option value="5">이름</option> <!-- input type text -->
			<option value="6">기간</option> <!-- input type text - input type text 검색버튼 클릭시 숫자체크할것 자리수 8자리 20230526-->
		</select>
		<button id="searchBtn">검색</button>
	</div>
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td style="width: 20px;" align="center">
						<input type="checkbox" name="checkAll">
					</td>
					<td style="width: 35px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table border="1">
			<!-- 아래 속성 name=tb 지움 -->
			<tbody id="tb" >
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td style="width: 20px;" align="center">
								<input type="checkbox" name="checkOne" value="${dto.num }">
							</td>
							<td style="width: 35px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }&page=${pagination.page}&searchType=${searchType}&searchDetail=${searchDetail}&beginDate=${beginDate}&endDate=${endDate}">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<div style="overflow: hidden; padding: 5px 40px 0 0">
			<button style="float: right;" id="deleteBtn">삭제</button>
		</div>
		
		<!-- 페이징 버튼 -->
		<div id="pageBtnBox">
			${pagination.pagination}
		</div> 
		
	</div>
	
	<script>
	
	// 게시글 선택 체크박스
	$("input[name='checkAll']").click((e) => {
		let checkOnes = $("input[name='checkOne']").toArray();
		if(e.target.checked){
			for(let checkOne of checkOnes)
				checkOne.checked = true;
		}else{
			for(let checkOne of checkOnes)
				checkOne.checked = false;
		}
	})
	// 선택 게시글 삭제 실행
	$("#deleteBtn").click(() => {
		let checkArr = [];
	    $("input[name='checkOne']:checked").each(function() {
			checkArr.push($(this).val());		    
	    });
	    if(checkArr.length == 0) {
	    	alert("삭제할 게시글을 하나 이상 선택해주세요.");
	    	return;
	    }
		if(confirm("삭제하시겠습니까?")){
		    $.ajax({
				url: './freeBoardDeletes.ino',
				data: JSON.stringify(checkArr), 
		        type: "post", 
	            contentType : 'application/json',
	            dataType : 'json', 
				success: (data) => {
					if(data.err == undefined){
						alert("삭제되었습니다.");
						location.href = './main.ino';
					}else{
						alert('Error: '+ data.err);
					}
				},
				error: (err) => {
					console.log(err);
				}
			})
		}
	});
	
	// 검색 실행
	const searchTypeArr = ['', 'codeType', 'num', 'title', 'content', 'name', 'regdate'];
	$("#searchBtn").click(() => {
		// 검색 타입
		let searchType = $("#searchType").val();
		// url 생성
		let path = '<%= request.getContextPath() %>';
		let searchUrl = path+'/search.ino?searchType='+searchTypeArr[searchType];
		
		if(searchType == '1'){ // 타입 검색
			searchUrl += '&searchDetail='+ $("#codeType").val();
		}else if(searchType == '2'){ // 번호 검색
			// 숫자 검사
			if(isNaN($("#searchDetail").val())){
				alert("숫자를 입력해주세요");
				$("#searchDetail").val('');
				return;
			}
			searchUrl += '&searchDetail='+ $("#searchDetail").val();	
		}else if(searchType == '6'){ // 기간 검색
			let beginDate = $("#beginDate").val();
			let endDate = $("#endDate").val()
			if(isNaN(beginDate) || isNaN(endDate)){
				alert("숫자를 입력해주세요");
				$("#beginDate").val('');
				$("#endDate").val('');
			}else if(beginDate.length != 8 || endDate.length != 8 ){
				alert("8자리를 입력해주세요. ex)20230531");
			}else if(!isValidDate(beginDate) || !isValidDate(endDate)){
				alert("날짜 범위를 초과하였습니다.");
			}else{
				searchUrl += '&beginDate='+ beginDate;
				searchUrl += '&endDate='+ endDate;
			}
		}else { // 제목, 내용, 이름 검색
			searchUrl += '&searchDetail='+ $("#searchDetail").val();
		}
		searchAjax(searchUrl);
	})
	
	// 메인 페이징
	$(document).on('click', '.paging > span > a', (e) => {
		e.preventDefault();
		searchAjax(e.target.href);
	})
	
	const searchAjax = (url) => {
		$.ajax({
			url: url,
			type: 'get',
			success: (res) => makeList(res),
			error: (err) => console.log("에러")
		})
	}
	
	const makeList = (res) => {
		// 기존 태그 삭제
		$("#tb tr").remove();
		// 리스트 작성
		let new_list = '';
		if(res.list.length == 0){
			new_list += '<tr><td style="width: 200px;" align="center">게시글이 없습니다.</td></tr>'					
		}else{
			res.list.forEach(dto => {
				new_list += '<tr>';
				new_list += '<td style="width: 20px;" align="center"><input type="checkbox" name="checkOne" value="'+dto.num+'"></td>'
				new_list += '<td style="width: 35px;" align="center">'+dto.codeType+'</td>';
				new_list += '<td style="width: 50px; padding-left: 10px;" align="center">'+dto.num+'</td>'; 
				new_list += '<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num='+dto.num
																								   +'&page='+res.pagination.page
																								   +'&searchType='+res.searchType
																								   +'&searchDetail='+res.searchDetail
																								   +'&beginDate='+res.beginDate
																								   +'&endDate='+res.endDate
																								   +'">'+dto.title+'</a></td>';
				new_list += '<td style="width: 48px; padding-left: 50px;" align="center">'+dto.name+'</td>';
				new_list += '<td style="width: 100px; padding-left: 95px;" align="center">'+dto.regdate+'</td>';
				new_list += '<tr>';
			})
		}
		// 리스트 추가	
		$("#tb").html(new_list);
		// 페이지 버튼 생성
		$("#pageBtnBox").html(res.pagination.pagination);
	}
	
	// 검색 박스 체인지 이벤트
	let typeArr = ['자유', '익명', 'QnA'];
	$("#searchType").change(() => {
		// 추가된 태그 삭제
		if($("#searchType").next().attr("id") != 'searchBtn'){
			$("#searchType").next().remove();
		}
		// 검색 조건에 맞는 태그 추가
		let name = $("#searchType").val()
		if(name == '1'){
			// 타입 검색
			let sel = document.createElement("select");
			sel.id = 'codeType';
			typeArr.forEach((type, idx) => {
				let op = document.createElement("option");
				op.innerText = type;
				op.value = (idx+1) < 10 ? '0'+(idx+1) : (idx+1);
				sel.append(op);
			})
			$("#searchType").after(sel);
		}else if(name == '6'){
			// 기간 검색
			let dateBox = document.createElement("span");
			let beginDate = document.createElement("input");
			beginDate.id = 'beginDate';
			beginDate.style.width = '70px';
			let endDate = document.createElement("input");
			endDate.id = 'endDate';
			endDate.style.width = '70px';
			dateBox.append(beginDate);
			dateBox.append(" ~ ");
			dateBox.append(endDate);
			$("#searchType").after(dateBox);
		}else if(name != '0'){
			// 전체를 제외한 나머지(전체는 기존 태그 삭제만 진행)
			let input = document.createElement("input");
			input.id = 'searchDetail';
			$("#searchType").after(input);
		}
	})
	
	// 날짜 범위 초과 검사
	const isValidDate = (dateString) => {
		const year = parseInt(dateString.substr(0, 4));
		const month = parseInt(dateString.substr(4, 2));
		const day = parseInt(dateString.substr(6, 2));
		const inputDate = new Date(year, month - 1, day);
		const inputYear = inputDate.getFullYear();
		const inputMonth = inputDate.getMonth() + 1;
		const inputDay = inputDate.getDate();
		if (
		  year === inputYear &&
		  month === inputMonth &&
		  day === inputDay &&
		  month >= 1 && month <= 12 &&
		  day >= 1 && day <= 31
		) return true;
		  
		return false;
	}
	
	</script>

</body>
</html>