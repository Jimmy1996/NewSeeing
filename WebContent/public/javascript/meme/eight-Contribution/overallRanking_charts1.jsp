<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document

$(function () {
    // Create the chart
    Highcharts.chart('overallRanking_charts', {
        chart: {
            type: 'column',
			backgroundColor:'transparent',
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },

        xAxis: {
            type: 'category',
			lineColor:'#3dffff',
			lineWidth: 1,
			tickWidth:0,
			labels:{ 
			       style:{
			             color: '#C7C8CA',
	                     fontSize:13,
						 }
				   },
        },
        yAxis: {
            title: {
                text: ''
            },
	//		alternateGridColor: 'rgba(2, 27, 38, 0.62)',
			gridLineColor: 'rgba(2, 27, 38, 0.62)',
			gridLineWidth:1,
			lineColor:'#3dffff',
			lineWidth: 1,
			labels:{ 
			       style:{
			             color: '#C7C8CA',
	                     fontSize:14,
						 }
				   },
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    format: '{point.y:.1f}%'
                },
             }
        },
        tooltip: {
        	backgroundColor:'rgba(13, 143, 143, 0.2)',
            headerFormat: '<span style="font-size:13px;color:white;">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b style="color:white;">{point.y:.1f}%</b  style="color:white;"> of total<br/>'
        },
        series: [{
            name: '',
            colorByPoint: true,
         
        data:[
        	<c:forEach items="${actorTotal}" var="totalMap">
            	<c:if test="${totalMap.key == 'total'}">
		                <c:forEach items="${totalMap.value}" var="totalList">
		                {
		              		<c:forEach items="${totalList}" var="total">
		              		<c:choose>
		              			<c:when test="${total.key != '电影票房'}">
					                    name: '${total.key}',
					                    y: ${total.value*100},
					                    drilldown: '${total.key}'
				                 </c:when>
				                  <c:otherwise>
					                  	name: '${total.key}',
					                    y: ${total.value*100},
					                    drilldown: null
				                  </c:otherwise>
					        </c:choose>
		                    </c:forEach>
		                }, 
		                </c:forEach>
		         </c:if>
        	</c:forEach>
        ]
    }],
        drilldown: {
        	   activeAxisLabelStyle: {
                   textDecoration: 'none',
                   color:'white',
                   fontSize:12,
               },
            series: [
            	<c:forEach items="${actorTotal}" var="totalMap">
            	<c:if test="${totalMap.key != 'total'}">
		            	{
		            		name: '${totalMap.key}',
			                id: '${totalMap.key}',
			                data: [
		                <c:forEach items="${totalMap.value}" var="totalList">
		                    [
		                    	<c:forEach items="${totalList}" var="total">
			                    	'${total.key}',
			                    	${total.value*100}
		                    	</c:forEach>
		                    ],
		                </c:forEach>
		                    ]
			            },
		         </c:if>
        	</c:forEach>
            ]
        }
    });
});
</script>