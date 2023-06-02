<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a id="toList">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<input type="hidden" name="codeType" value="${freeBoardDto.codeType }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" id="modifyBtn">
					<input type="button" value="삭제" id="deleteBtn">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
	
	<script>
	let params = new URLSearchParams(window.location.search);
	$(document).ready(function(){
		let path = '<%= request.getContextPath() %>';
		$("#toList").attr('href', path+'/main.ino?page='+params.get('page')
												 +'&searchType='+params.get('searchType')
												 +'&searchDetail='+params.get('searchDetail')
												 +'&beginDate='+params.get('beginDate')
												 +'&endDate='+params.get('endDate'))
	})
	let options = $("select[name='codeType'] option").toArray();
	for(let option of options){
		if($("input[name='codeType']").val() == option.value)
			option.selected = true;
	}
	
	$('#modifyBtn').click(() => {
		let formData = {
			"codeType" : $("select[name='codeType']").val(),
			"num" : $("input[name='num']").val(),	
			"name" : $("input[name='name']").val(),
			"title" : $("input[name='title']").val(),
			"content" : $("textarea[name='content']").val()
		}
		$.ajax({
			url: './freeBoardModify.ino',
			data: JSON.stringify(formData), 
	        type: "post", 
            contentType : 'application/json',
            dataType : 'json', 
			success: (data) => {
				if(data.err == undefined){
					if(confirm('메인으로 이동하시겠습니까?(취소 시 상세 화면으로 이동)')){
						location.href = './main.ino';								
					}else{
						location.href = './freeBoardDetail.ino?num='+ data.dto.num;								
					}
				}else{
					alert('Error: '+ data.err);
				} 
			},
			error: (err) => {
				console.log(err);
			}
		})
	})
	
	$('#deleteBtn').click(() => {
		let formData = {"num" : $("input[name='num']").val()}
		$.ajax({
			url: './freeBoardDelete.ino',
			data: JSON.stringify(formData), 
	        type: "post", 
            contentType: 'application/json',
            dataType: 'json', 
			success: (data) => {
				if(data.err == undefined){
					alert('삭제되었습니다.');
					location.href = './main.ino';
				}else{
					alert('Error: '+ data.err);
				} 
			},
			error: (err) => {
				console.log(err);
			}
		})
		
	})
	</script>
	
</body>
</html>