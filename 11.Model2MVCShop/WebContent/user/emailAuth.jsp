<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>���� ���� ȭ��</title>
<script  type="text/javascript">
	function check(){
		var form = document.authenform;
		var authNum = ${authNum};
		
		if(!form.authnum.value){
			alert("������ȣ�� �Է��ϼ���.");
			return false;
		}
		if(form.authnum.value != authNum){
			alert("Ʋ�� ������ȣ�Դϴ�. ������ȣ�� �ٽ� �Է����ּ���.");
			form.authnum.value = "";
			return false;
		}
		if(form.authnum.value==authNum){
			alert("�����Ϸ�");
			self.close();
		}
	}
</script>
<center>
	<h5> ������ȣ 7�ڸ��� �Է��ϼ���.</h5>
	
		<div class="container">
			<form method="post" name="authenform" onSubmit="return check();">
				<input type="text" name="authnum"> <br/><br/>
				<input tupe="submit" class = btn btn-info" value = "Submit">
			</form>
		</div>
	</center>

</head>
</html>