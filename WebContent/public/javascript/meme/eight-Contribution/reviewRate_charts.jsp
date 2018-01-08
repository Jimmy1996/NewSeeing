<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document

$(function(){

var myChart = echarts.init(document.getElementById('reviewRate_charts'));

var xAxisData = [
	<c:forEach items="${actorEmotion}" var="emotion">
		'${emotion.name}',
	</c:forEach>
];
var data1 = [
	<c:forEach items="${actorEmotion}" var="emotion">
		${emotion.good},
	</c:forEach>
];
var data2 = [
	<c:forEach items="${actorEmotion}" var="emotion">
		${ emotion.bad},
	</c:forEach>
];

/*for (var i = 0; i < 8; i++) {
    xAxisData.push('Class' + i);
    data1.push((Math.random() * 2).toFixed(2));
    data2.push(-Math.random().toFixed(2));
}*/

var itemStyle = {
    normal: {
    },
    emphasis: {
        barBorderWidth: 1,
        shadowBlur: 10,
        shadowOffsetX: 0,
        shadowOffsetY: 0,
        shadowColor: 'rgba(0,0,0,0.5)'
    }
};

option = {
    legend: {
        data: ['positive', 'negative'],
        align: 'left',
		top:25,
        right: 20,
		itemWidth:10,
		itemheight:10,
		textStyle: {
                        color: '#C7C8CA',
	                    fontSize:10,
                    },
		show:true,
    },
	
	color:['#39fdff','red'],
    tooltip: {},
    xAxis: {
        data: xAxisData,
        silent: false,
        axisLine: {onZero: true},
        splitArea: {show: false},
		axisTick: {show: false},	
		axisLabel:{
                    show: true,
                    textStyle: {
                        color: '#C7C8CA',
	                    fontSize:5,
                    }
                },
		axisLine: {
	            	lineStyle: {
	            		color:'#3dffff'
	            	}
	            },
    },
    yAxis: {
        inverse: false,
		splitLine: {show: false},
        splitArea: {show: false},
		axisTick: {show: false},
		axisLine: {show:false},
		axisLabel:{show: true,
                   textStyle: {
                        color: '#C7C8CA',
						}
					}
    },
    grid: {
        left: 50,
    },

    series: [
        {
            name: 'positive',
            type: 'bar',
            stack: 'one',
            itemStyle: {normal: {
	            		label : {
	            			show: false, 
	            			position: 'top',
	            			
	            			textStyle:{
	            				color: '#fff',
	            				fontSize:8
	            			}
	            		}
	            	}
					
					},
            data: data1,
			barWidth:8,
        },
        {
            name: 'negative',
            type: 'bar',
            stack: 'one',
			itemStyle: {normal: {
	            		label : {
	            			
	            			show: false, 
	            			position: 'top',
	            			
	            			textStyle:{
	            				color: '#fff',
	            				fontSize:8
	            			}
	            		}
	            	}
				},
			data: data2,
			barWidth:8,
        }
    ]
};

myChart.on('brushSelected', renderBrushed);

function renderBrushed(params) {
    var brushed = [];
    var brushComponent = params.batch[0];

    for (var sIdx = 0; sIdx < brushComponent.selected.length; sIdx++) {
        var rawIndices = brushComponent.selected[sIdx].dataIndex;
        brushed.push('[Series ' + sIdx + '] ' + rawIndices.join(', '));
    }

    myChart.setOption({
        title: {
            backgroundColor: '#333',
            text: 'SELECTED DATA INDICES: \n' + brushed.join('\n'),
            bottom: 0,
            right: 0,
            width: 100,
            textStyle: {
                fontSize: 12,
                color: '#fff'
            }
        }
    });
}
 myChart.setOption(option);
})
</script>