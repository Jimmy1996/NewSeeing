<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
// JavaScript Document
$(function(){
	var myChart = echarts.init(document.getElementById('creatContributeList_charts'));

option = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        show:false,
        data: ['主创贡献'],
		textStyle: {
                        color: '#fff',
					    fontSize:15,	
                    },
		top:0,
		left:90,		
		itemWidth:15,
		itemHeight:10,			
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis:  {
        type: 'value',
		splitLine: {
	            	show:false
	            },
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:15,	
                    }
                },
		axisLine: {
			lineStyle: {
	            		color:'#3dffff'
	            	}
			},
		
    },
    yAxis: {
        type: 'category',
      //data: ['上映第四周','上映第三周','上映第二周','上映第一周','上映前一月'],
        data:[
        	<c:set var="startIndex" value="${fn:length(actorContribution)-1 }"></c:set>
        	<c:forEach items="${actorContribution}" var="conList" varStatus="status">
        		<c:forEach items="${actorContribution[startIndex - status.index]}" var="contribution">
        			'${contribution.key}',
        		</c:forEach>
        	</c:forEach>
        ],
		axisTick: {show: false},
		
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:15,	
                    }
                },
		axisLine: {show:false},

    },
    series: 
        {
    	name: '主创贡献',
            type: 'bar',
            stack: '总量',
            label: {
                normal: {
                    show: false,
                    position: 'insideRight'
                }
            },
            //data: [820, 832, 601, 634, 590],
            data:[
            	<c:set var="startIndex" value="${fn:length(actorContribution)-1 }"></c:set>
		       	<c:forEach items="${actorContribution}" var="conList" varStatus="status">
		       		<c:forEach items="${actorContribution[startIndex - status.index]}" var="contribution">
		       			'${contribution.value}',
		       		</c:forEach>
		       	</c:forEach>
		       ],
            itemStyle:{
                normal:{color:'#01E290'}
            },
        }
};
 myChart.setOption(option);
})
</script>