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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form id="insertForm" name="insertForm">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="�۾���" name="insertBtn">
					<input type="button" value="�ٽþ���" onclick="reset()">
					<input type="button" value="���" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
	
	
	
	<script>
		let form = document.forms.insertForm;
	
		form.insertBtn.onclick = () => {
			
			if(confirm("���� ����Ͻðڽ��ϱ�?")){
				// ��ȿ�� �˻�
				if(form.name.value == ''){
					alert("�̸��� �ʼ����Դϴ�.");
					return;
				}else if(form.title.value == ''){
					alert("������ �ʼ����Դϴ�.");
					return;
				}else if(form.content.value == ''){
					alert("������ �ʼ����Դϴ�.");
					return;
				}
				// ������ ���� �� ����
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
							if(confirm('�������� �̵��Ͻðڽ��ϱ�?(��� �� �� ȭ������ �̵�)')){
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