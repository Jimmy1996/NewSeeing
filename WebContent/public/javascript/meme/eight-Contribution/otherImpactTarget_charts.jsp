<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
//其他影响因素
$(function(){

   	/*var dataBJ = [
	    [55,9,56,0.46,18,6,1],
	    [41,11,40,0.43,21,7,12],
	    [108,63,116,1.48,44,26,15],
	    [33,6,29,0.34,13,5,16],
	    [154,117,157,3.05,92,58,26],
	];*/
	var dataLove = [
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.love},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.love * 2},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.love * 3},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.love * 4},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.love * 5},
			</c:forEach>
		]
	];

	/*var dataGZ = [
	    [26,37,27,1.163,27,13,1],
	    [56,52,69,1.067,92,16,6],
	    [109,68,87,0.996,74,29,15],
	    [106,116,188,3.628,101,16,30],
	    [118,50,0,1.383,76,11,31]
	];*/
	var dataMatch = [
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.match},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.match * 2},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.match * 3},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.match * 4},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.match * 5},
			</c:forEach>
		],
	];

	/*var dataSH = [
	    [91,45,125,0.82,34,23,1],
	    [80,55,80,1.01,75,24,10],
	    [117,81,124,1.03,45,24,11],
	    [174,131,174,1.55,108,50,30],
	    [187,143,201,1.39,89,53,31]
	];*/
	var dataCover = [
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.cover},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.cover * 2},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.cover * 3},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.cover * 4},
			</c:forEach>
		],
		[
			<c:forEach items="${actorOtherImpact}" var="other">
					${other.cover * 5},
			</c:forEach>
		],
	];

	var lineStyle = {
	    normal: {
	        width: 1,
	        opacity: 0.5
	    }
	};

	option = {
	    backgroundColor: 'transparent',
	    title: {
	      text:null,
	    },
	    legend: {
	        //bottom: -6,
	        left:170,
	        data: ['preference', 'matching', 'media rate'],
	        itemGap: 0,
	        textStyle: {
	            color: '#fff',
	            fontSize: 6
	        },
	        selectedMode: 'single',
	        position:left,
	    },
	    // visualMap: {
	    //     show: true,
	    //     min: 0,
	    //     max: 20,
	    //     dimension: 6,
	    //     inRange: {
	    //         colorLightness: [0.5, 0.8]
	    //     }
	    // },
	    radar: {
	    	nameGap:4,
	    	center:['33%','50%'], // 图的位置
	    	/*indicator: [
	            {name: 'AQI', max: 5},
	            {name: 'PM2.5', max: 5},
	            {name: 'PM10', max: 5},
	            {name: 'CO', max: 5},
	            {name: 'NO2', max: 5},
	            {name: 'SO2', max: 5}
	        ],*/
	        indicator:[
	    			<c:forEach items="${actorOtherImpact}" var="other">
	    					{name: '${other.name}', max: 5},
	    			</c:forEach>
	        ],
	        shape: 'circle',
	        symbolSize:3,
	        itemHeight:50,
	        splitNumber: 3,
	        name: {
	            textStyle: {
	                color: 'rgb(238, 197, 102)',
	                fontSize:3,
	            }
	        },
	        splitLine: {
	            lineStyle: {
	                color: [
	                    'rgba(238, 197, 102, 0.1)', 'rgba(238, 197, 102, 0.2)',
	                    'rgba(238, 197, 102, 0.4)', 'rgba(238, 197, 102, 0.6)',
	                    'rgba(238, 197, 102, 0.8)', 'rgba(238, 197, 102, 1)'
	                ].reverse()
	            }
	        },
	        splitArea: {
	            show: false
	        },
	        axisLine: {
	            lineStyle: {
	                color: 'rgba(238, 197, 102, 0.5)'
	            }
	        }

	    },
	
	    series: [
	        {
	            name: 'preference',
	            type: 'radar',
	            lineStyle: lineStyle,
	            data: dataLove,
	            symbol: 'none',
	            itemStyle: {
	                normal: {
	                    color: '#F9713C'
	                }
	            },
	            areaStyle: {
	                normal: {
	                    opacity: 0.1
	                }
	            }
	        },
	        {
	            name: 'matching',
	            type: 'radar',
	            lineStyle: lineStyle,
	            data: dataMatch,
	            symbol: 'none',
	            itemStyle: {
	                normal: {
	                    color: '#B3E4A1'
	                }
	            },
	            areaStyle: {
	                normal: {
	                    opacity: 0.05
	                }
	            }
	        },
	        {
	            name: 'media rate',
	            type: 'radar',
	            lineStyle: lineStyle,
	            data: dataCover,
	            symbol: 'none',
	            itemStyle: {
	                normal: {
	                    color: 'rgb(238, 197, 102)'
	                }
	            },
	            areaStyle: {
	                normal: {
	                    opacity: 0.05
	                }
	            }
	        }
	    ]
	};
	var myChart = echarts.init(document.getElementById('otherImpactTarget_charts'));

    myChart.setOption(option);
})
</script>