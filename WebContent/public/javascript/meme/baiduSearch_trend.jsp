<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
// JavaScript Document
var timeData = [
    '2009/6/12 2:00', '2009/6/12 3:00', '2009/6/12 4:00', 
	'2009/6/12 5:00', '2009/6/12 6:00', '2009/6/12 7:00', 
	'2009/6/12 8:00', '2009/6/12 9:00', '2009/6/12 10:00', 
	'2009/6/12 11:00', '2009/6/12 12:00', '2009/6/12 13:00', 
	'2009/6/12 14:00', '2009/6/12 15:00', '2009/6/12 16:00', 
	'2009/6/12 17:00', '2009/6/12 18:00', '2009/6/12 19:00', 
	'2009/6/12 20:00', '2009/6/12 21:00', '2009/6/12 22:00'
	
];

timeData = timeData.map(function (str) {
    return str.replace('2009/', '');
});

option = {

    tooltip: {
        trigger: 'axis',
        axisPointer: {
            animation: false
        }
    },
    legend: {
        data:['流量'],
        x: 'left'
    },
    toolbox: {
        feature: {
            dataZoom: {
                yAxisIndex: 'none'
            },
            restore: {},
            saveAsImage: {}
        }
    },
    axisPointer: {
        link: {xAxisIndex: 'all'}
    },

    grid: [{
        left: 50,
        right: 50,
        height: '35%'
    }],
    xAxis :{
            type : 'category',
            boundaryGap : false,
            axisLine: {onZero: true},
            data: timeData
        },
    yAxis : {
            name : '流量(m^3/s)',
            type : 'value',
            max : 500
        },
    series : [
        {
            name:'流量',
            type:'line',
            symbolSize: 8,
            hoverAnimation: false,
            data:[
                0.97,0.96,0.96,
				0.95,0.95,0.94,
				0.94,0.94,0.94,
				0.94,0.94,0.94,
				0.94,0.94,0.94,
				0.94,0.94,0.94,
				0.94,0.94,0.94]
        }
    ]
};
</script>