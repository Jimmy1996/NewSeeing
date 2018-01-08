<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>

$(function(){

	var option = {
	    color: ['#3dffff'],
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        },
	        textStyle:{
	        	fontSize:20
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	           // data : ['1月', '2月', '3月', '4月', '5月', '6月', '7月'], //横坐标数据

	           data : [
	        	   <c:forEach items="${movieBox}"  var="box">
	        	   		"<c:out value="${box.week}"/>",
	        	   		//"${box.week}",
	        	   </c:forEach>
	           ],
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff',
                        fontSize:15
                    }
                },
	            axisTick: {
	                show:false,
	            },
	            axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },

	            splitLine: {
	            	show:false
	            }
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff',
                        fontSize:15
                    }
                },
                axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
			    axisTick: { show:false,},
				
	            splitArea: {
		            show: true,
		            areaStyle: {
		            	color:['rgba(2,31,41,0.6)','rgba(2,31,41,0)']
		            }
		        },
	            splitLine: {
	            	show:false
	            }
	        }
	    ],
	    series : [
	        {
	            name:'box office',//柱型图的柱子文字
	            type:'bar',
	            barWidth: '20%',
	            //data:[10, 52, 200, 334, 390, 330, 220],//柱型图的柱子数据
	            data:[
	            	<c:forEach items="${movieBox}"  var="box">
		    	   			<c:out value="${box.box}"/>,
		    	   </c:forEach>
	            ],
	            itemStyle : { 
	            	normal: {
	            		label : {
	            			
	            			show: true, 
	            			position: 'top',
	            			
	            			textStyle:{
	            				color: '#fff',
	            				fontSize:14
	            			}
	            		}
	            	}
	            }
	        }
	    ]
	};

	var myChart = echarts.init(document.getElementById('boxOfficeTrend'));
	myChart.showLoading();
	
    myChart.setOption(option);
    myChart.hideLoading();
})
</script>
