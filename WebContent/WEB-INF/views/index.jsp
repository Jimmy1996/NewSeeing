<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>seeing—首页</title>
	<link rel="stylesheet" href="./public/stylesheets/index.css">
</head>

<script type="text/javascript">
if("${errorInfo}" != ""){
	alert("${errorInfo}");
}
</script>

<body>
	<div class="index_page">
		<div class="container">
			<div class="logo">
				<img src="./public/images/index_logo.png" alt="seeing logo">
			</div>
			<div class="search">
				<form method="post" action="./searchMovie.action">
					<input type="text" name="movieName"></input>
					<button type="submit">
						<img src="./public/images/index_search.png" alt="search">
					</button>
				</form>
			</div>
			<!--<div class="recommend">
				<span>猜你喜欢</span>
				<ul>
					<li><a href="#">但丁密码</a></li>
					<li><a href="#">速度与激情</a></li>
					<li><a href="#">功夫熊猫</a></li>
					<li><a href="#">侏罗纪公园</a></li>
					<li><a href="#">爱宠大机密</a></li>
				</ul>
			</div>-->
		</div>
	</div>
	<footer>
	   <!----	<p>copyright©广东外语外贸大学 广外数据挖掘实验室</p> ------>
	       <p>CopyRight@Data Mining Lab of GuangDong University of Foreign Study</p>
	</footer>
</body>
</html>