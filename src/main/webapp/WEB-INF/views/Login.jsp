<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>�α���������</h2>
	<form action="${pageContext.request.contextPath}/loginpage" method="post">
		<input name="username" type="text">
		<input name="password" type="password">
		<input type="submit" value="�α���">
	</form>
 <!--  <main>
    <img
         class="logo"
         src="./images/codestates-logo1.png"
         alt="CODE_STATES_LOGO"
         />

    <fieldset>
      <input type="text" id="username" placeholder="���̵�" />
    </fieldset>

    <div class="success-message hide">����� �� �ִ� ���̵��Դϴ�</div>
    <div class="failure-message hide">���̵�� 4~12�����̾�� �մϴ�</div>
    <div class="failure-message2 hide">���� �Ǵ� ���ڸ� �����մϴ�</div>

    <fieldset>
      <input type="password" id="password" placeholder="��й�ȣ" />
    </fieldset>

    <div class="strongPassword-message hide">8���� �̻�, ����, ����, Ư������(@$!%*#?&)�� ����ϼ���</div>

    <fieldset>
      <input
             type="password"
             id="password-retype"
             placeholder="��й�ȣ Ȯ��"
             />
    </fieldset>

    <div class="mismatch-message hide">��й�ȣ�� ��ġ���� �ʽ��ϴ�</div>

    <fieldset class="signup">
      <button>�α���</button>
    </fieldset>
  </main> -->
</body>
    <script src="script2.js"></script>
</html>