<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="true"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>Home</title>
	<link href="<c:url value='/resources/css/bootstrap.min.css' />" rel="stylesheet" media="screen">
	<script src="<c:url value='/resources/js/jquery.dataTables.js' />"></script>
<script src="<c:url value='/resources/js/jquery.js' />"></script>
	
		<script type="text/javascript" charset="utf-8">
		$.extend( $.fn.dataTableExt.oStdClasses, {
			"sSortAsc": "header headerSortDown",
			"sSortDesc": "header headerSortUp",
			"sSortable": "header"
		} );

	
		/* API method to get paging information */
		$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
		{
			return {
				"iStart":         oSettings._iDisplayStart,
				"iEnd":           oSettings.fnDisplayEnd(),
				"iLength":        oSettings._iDisplayLength,
				"iTotal":         oSettings.fnRecordsTotal(),
				"iFilteredTotal": oSettings.fnRecordsDisplay(),
				"iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
				"iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
			};
		}

		/* Bootstrap style pagination control */
		$.extend( $.fn.dataTableExt.oPagination, {
			"bootstrap": {
				"fnInit": function( oSettings, nPaging, fnDraw ) {
					var oLang = oSettings.oLanguage.oPaginate;
					var fnClickHandler = function ( e ) {
						e.preventDefault();
						if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
							fnDraw( oSettings );
						}
					};

					$(nPaging).addClass('pagination').append(
						'<ul>'+
							'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
							'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
						'</ul>'
					);
					var els = $('a', nPaging);
					$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
					$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
				},

				"fnUpdate": function ( oSettings, fnDraw ) {
					var iListLength = 5;
					var oPaging = oSettings.oInstance.fnPagingInfo();
					var an = oSettings.aanFeatures.p;
					var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

					if ( oPaging.iTotalPages < iListLength) {
						iStart = 1;
						iEnd = oPaging.iTotalPages;
					}
					else if ( oPaging.iPage <= iHalf ) {
						iStart = 1;
						iEnd = iListLength;
					} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
						iStart = oPaging.iTotalPages - iListLength + 1;
						iEnd = oPaging.iTotalPages;
					} else {
						iStart = oPaging.iPage - iHalf + 1;
						iEnd = iStart + iListLength - 1;
					}

					for ( i=0, iLen=an.length ; i<iLen ; i++ ) {
						// Remove the middle elements
						$('li:gt(0)', an[i]).filter(':not(:last)').remove();

						// Add the new list items and their event handlers
						for ( j=iStart ; j<=iEnd ; j++ ) {
							sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
							$('<li '+sClass+'><a href="#">'+j+'</a></li>')
								.insertBefore( $('li:last', an[i])[0] )
								.bind('click', function (e) {
									e.preventDefault();
									oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
									fnDraw( oSettings );
								} );
						}

						// Add / remove disabled classes from the static elements
						if ( oPaging.iPage === 0 ) {
							$('li:first', an[i]).addClass('disabled');
						} else {
							$('li:first', an[i]).removeClass('disabled');
						}

						if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
							$('li:last', an[i]).addClass('disabled');
						} else {
							$('li:last', an[i]).removeClass('disabled');
						}
					}
				}
			}
		} );


			/* Table initialisation */
			$(document).ready(function() {
				$('#cdTable').dataTable( {
					"sDom": "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>",
					"sPaginationType": "bootstrap"
				} );
			} );
		</script>
</head>
<body>

	<table id="cdTable"
					class="table table-striped table-bordered table-hover datatable">
					<thead>
						<tr>
							<th>ID</th>
							<th>Фамилия</th>
					
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cdList}" var="cd">
							<tr>
							
								<td>${cd.artist}</td>
								<td>${cd.title}</td>
							
							</tr>
						</c:forEach>
					</tbody>
				</table>
				


<form:form modelAttribute="FileUpload" name="frm" method="post"

enctype="multipart/form-data">

<fieldset><legend>Upload File</legend>

<table>

<tr>


<td><input name="fileData" id="image" type="file"></td>

</tr>

<tr>

<td><br />

</td>

<td><input type="submit" value="Upload" /></td>

</tr>

</table>

</fieldset>

</form:form>

	
				

</body>
</html>
