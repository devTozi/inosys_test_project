<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form id="insertForm" name="insertForm">

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
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" name="insertBtn">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
	
	
	
	<script>
		let form = document.forms.insertForm;
	
		form.insertBtn.onclick = () => {
			
			if(confirm("글을 등록하시겠습니까?")){
				// 유효성 검사
				if(form.name.value == ''){
					alert("이름은 필수값입니다.");
					return;
				}else if(form.title.value == ''){
					alert("제목은 필수값입니다.");
					return;
				}else if(form.content.value == ''){
					alert("내용은 필수값입니다.");
					return;
				}
				// 데이터 생성 및 전송
				let formData = {
					"codeType" : form.codeType.value,
					"name" : form.name.value,
					"title" : form.title.value,
					"content" : form.content.value
				}
				$.ajax({
					url: './freeBoardInsertPro.ino',
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
			}
		}
	
	</script>


</body>
</html>