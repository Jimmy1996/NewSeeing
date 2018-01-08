<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document
$(function(){
	var myChart = echarts.init(document.getElementById('boxOffice_douBanScore_charts'));

var colors = ['#d14a61','#5793f3'];

option = {
    color: colors,

    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'cross'
        }
    },
    grid: {
        right: '20%'
    },
  
    legend: {
        data:['box office','score'],
		textStyle: {
                        color: '#fff',
					    fontSize:16,	
                    },
		right:120,
		top:0,
    },
    xAxis: [
        {
            type: 'category',
            axisTick: {
                alignWithLabel: true
            },
            //data: ['1月','2月','3月','4月','5月','6月','7月'],
            data: [
            	<c:forEach items="${actorScore}" var="actor">
            		'${actor.name}',
            	</c:forEach>
            ],
			splitLine: {
	            	show:false
	            },
		    axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#fff',
					    fontSize:16,	
                    }
                },
	    	axisLine: {
		        	lineStyle: {
	            		color:'#3dffff'
	            	}
			},
        }
    ],
    yAxis: [
        {
            type: 'value',
            name: 'box office',
			
            min: 0,
            max: ${maxOrdinate},
            position: 'left',
            axisLine: {
                lineStyle: {
                    color: colors[0]
                }
            },
            axisLabel: {
                formatter: '{value}',
	            textStyle: {
                        fontSize:14
                    }

            },
			splitLine: {
	            	show:true,
					lineStyle: {
	            		color:'#022833'
	            	}
	            },
        },
        {
            type: 'value',
            name: '降水量',
            min: 0,
            max: 250,
            position: 'right',
            offset: 80,
            axisLine: {
                show:false,
            },
			splitLine: {
	            	show:false
	            },
            
        },
        {
            type: 'value',
            name: 'score',
            min: 0,
            max: 10,
            position: 'right',
            axisLine: {
                lineStyle: {
                    color: colors[1]
                }
            },
            axisLabel: {
                formatter: '{value}',
				textStyle: {
                        fontSize:14
                    }

            },
			splitLine: {
	            	show:false
	            },
        }
    ],
    series: [
        {
            name:'box office',
            type:'bar',
			barWidth:12,
			//data:[ 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6]
			 data: [
	            	<c:forEach items="${actorScore}" var="actor">
	            		${actor.box},
	            	</c:forEach>
	            ]
       },
        {
            name:'score',
            type:'line',
            yAxisIndex: 2,
         // data:[4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5]
            data: [
            	<c:forEach items="${actorScore}" var="actor">
            		${actor.score},
            	</c:forEach>
            ]
        }
    ]
};
 myChart.setOption(option);
})
</script>