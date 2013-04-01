<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="true"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Сладкова - Тестовое задание</title>
	<link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet" media="screen">
	
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.dataTables.min.js' />"></script>
	<script src="<c:url value='/resources/js/paging.js' />"></script>
<script>
	$(document).ready(function() {
	    $('#cdTable').dataTable( {
	        "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
	        "sPaginationType" : "bootstrap",
	        "bFilter": false,
	        "bLengthChange": false,
	        "iDisplayLength": 10,
	        "bInfo": false,
	        "oLanguage" : {
	        	"oPaginate" : {
					"sPrevious" : "Пред.",
					"sNext" : "След.",
				}
	        }
	    } );
	} );
	$.extend( $.fn.dataTableExt.oStdClasses, {
	    "sWrapper": "dataTables_wrapper form-inline"
	} );
</script>
</head>
<body>
	<div class="container" style="padding-top: 10px;">
		<div class="well">
			<a class="btn btn-info pull-right" target="_blank" href="<c:url value='/resources/catalog.xml' />">Скачать XML</a>
			<form:form modelAttribute="FileUpload" method="POST" enctype="multipart/form-data">
				<fieldset>
					<input name="fileData" type="file">
					<button type="submit" class="btn btn-inverse">Загрузить на сервер</button>
				</fieldset>
			</form:form>
		</div>
		<table id="cdTable"
			class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>TITLE</th>
					<th>ARTIST</th>
					<th>COUNTRY</th>
					<th>COMPANY</th>
					<th>PRICE</th>
					<th>YEAR</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cdList}" var="cd">
					<tr>
						<td>${cd.title}</td>
						<td>${cd.artist}</td>
						<td>${cd.country}</td>
						<td>${cd.company}</td>
						<td>${cd.price}</td>
						<td>${cd.year}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>