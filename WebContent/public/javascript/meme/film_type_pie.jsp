<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
//views/single_film/persona.html 演员电影类型占比——饼图

/*require.config({
    paths : {
        echarts : '../public/javascript/lib'
    }
});

require([ "echarts", "echarts/chart/pie"],*/
$(function(){
	/*
	var myChart = echarts.init(document.getElementById('pieCharts'));
	var option = {
		
	    title : {
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)",
	        textStyle:{
	        	fontSize:20
	        }
	    },
	    series : [
	        {
	            name: '电影类型', //点击饼状图时的文字
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '50%'],
	            data:[//饼状图的块名及其对应值
	                {value:3, name:'直接访问'},
	                {value:3, name:'邮件营销'},
	                {value:2, name:'联盟广告'},
	                {value:1, name:'视频广告'},
	                {value:1, name:'搜索引擎'},
	            ],
	            itemStyle: {
	            	normal: {
	            		label : {
	            			
	            			show: true, 
	            			position: 'top',
	            			textStyle:{
	            				color: '#fff',
	            				fontSize:18
	            			}
	            		}
	            	},
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
	};



    myChart.setOption(option);
	*/
	<c:forEach items="${actorMovieType}" var="movieType" varStatus="statu"> //test
		var myChart${statu.index+1} = echarts.init(document.getElementById('pieCharts${statu.index+1}'));
		var option${statu.index+1} = {
		    title : {
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)",
		        textStyle:{
		        	fontSize:20
		        }
		    },
		    series : [
		        {
		            name: '电影类型', //点击饼状图时的文字
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '50%'],
		       /*     data:[//饼状图的块名及其对应值
		                {value:3, name:'直接访问'},
		                {value:3, name:'邮件营销'},
		                {value:2, name:'联盟广告'},
		                {value:1, name:'视频广告'},
		                {value:1, name:'搜索引擎'},
		            ],*/
		            data:[
		            	<c:forEach items="${movieType}" var="typeMap">
		            	{value:${typeMap.value}, name:'${typeMap.key}'},
		            	</c:forEach>
		            ],
		            itemStyle: {
		            	normal: {
		            		label : {
		            			
		            			show: true, 
		            			position: 'top',
		            			textStyle:{
		            				color: '#fff',
		            				fontSize:18
		            			}
		            		}
		            	},
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
	    myChart${statu.index+1}.setOption(option${statu.index+1});
	</c:forEach>
    console.log('0')
})
</script>