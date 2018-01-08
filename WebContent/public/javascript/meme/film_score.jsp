<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document
$(function(){
	var myChart = echarts.init(document.getElementById('film_score'));
option = {
	title:{
		show:false,
		},
	color: ['#01E290'],
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'shadow'
        }
    },
    legend: {
        show:false,
		    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: {
        type: 'value',
        boundaryGap: [0, 0.01],
		 splitLine:{show: false},//去除网格线
		 axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
                    }
                },
	     axisTick: {show: false},
	     axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    yAxis: {
        type: 'category',
        data: ['weibo','douban','m-time'],// 纵坐标名字
		axisTick: {show: false},
		
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:13,	
                    }
                },
		axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    series: [
	
        {
            name: 'score',
            type: 'bar',
            data: [${weiboScore}, ${doubanScore},${mtimeScore}],// 纵坐标数据
			barGap:'60%',
			barWidth:'5px',
        },

    ]
};
 myChart.setOption(option);
})
</script>