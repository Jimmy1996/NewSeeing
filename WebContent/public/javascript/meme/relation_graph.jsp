<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
require.config({
    paths : {
        echarts : './public/javascript/lib/echarts-2.2.7/build/dist'
    }
});

require([ "echarts", "echarts/chart/force"], function(ec) {
var myChart = ec.init(document.getElementById('actorMapEchart'), 'macarons');
var option = {
    tooltip : {
        show : false
    },
    calculable : false,
    animation: false,
    series : [ {
        type : 'force',
        name : "Force tree",
        draggable:false,
        // useWorker:true,
        steps:1,
        gravity:0.6,

        roam:false,
        itemStyle : {

            normal : {
                linkStyle: {
                    type: 'curve',
                    color:'#2aaa90',
                    width:2
                }
                
            },

            emphasis:{
                label : {show : true},
                nodeStyle : {
                    color:'#f1ab66',
                    borderColor : 'rgba(255,255,255,1)',
                    borderWidth : 3
                }
            }
        },

        categories : [ 

            //第一类型节点的样式

            {
                name : '0',
                symbolSize:30,
                itemStyle:{
                    normal:{
                        color:'#24b1b6',
                        borderColor:'#18838b',
                        borderWidth:6,
                        borderWidth : 0,
                        label : {
                            show : true,
                            textStyle:{
                                fontSize:18
                            }
                        }
                
                    },

                    emphasis:{
                        borderWidth:6,
                        borderColor:'#fff',
                        label : {
                            show : true,
                            textStyle:{
                                fontSize:18
                            }
                        }
                    }
                }
            }, 

            //第二类型节点的样式

            {
                name : '1',
                symbolSize:15,
                itemStyle:{
                    normal:{
                        color:'#2aaa90',
                        borderWidth : 0,
                        label : {
                            show : true,
                            textStyle:{
                                fontSize:15
                            }
                        } 
                    },
                    emphasis:{
                        borderColor:'#fff',
                        label : {
                            show : true,
                            textStyle:{
                                fontSize:15
                            }
                        }
                    }
                }
            }, 

            //第三类型节点的样式

            {
                name : '2',
                symbolSize:25,
                itemStyle:{
                    normal:{
                        color:'#24b6bc',
                        borderWidth : 0,
                        label : {
                            show : true,
                            textStyle:{
                                fontSize:18
                            }
                        } 
                    },

                    emphasis:{
                        borderWidth:4,
                        borderColor:'#fff',

                        label : {
                            show : true,
                            textStyle:{
                                fontSize:18
                            }
                        }
                    }
                }
            }
        ],
		/*
        nodes : [
            {id:0,category:0,name:'film',label:'但丁密码',ignore:false,flag:true,initial:[300,320],fixX:true,fixY:true,card:'film',},
            {id:1,category:1,name:'role',label:'角色1',ignore:true,flag:true,},
            {id:2,category:1,name:'role1',label:'角色2',ignore:true,flag:true,},
            {id:3,category:1,name:'role2',label:'角色3',ignore:true,flag:true,},
            {id:4,category:1,name:'role3',label:'角色4',ignore:true,flag:true,},
            {id:5,category:1,name:'role4',label:'角色5',ignore:true,flag:true,}, 
            {id:6,category:1,name:'role5',label:'角色6',ignore:true,flag:true,},
            {id:7,category:2,name:'0',label:'罗伯特·兰登',ignore:true,flag:true,card:'actor',},
            {id:8,category:2,name:'1',label:'西恩娜·布鲁克斯',ignore:true,flag:true,card:'actor'},
            {id:9,category:2,name:'2',label:'哈利·希姆斯',ignore:true,flag:true,card:'actor'},
            {id:10,category:2,name:'3',label:'克里斯多夫·布鲁多',ignore:true,flag:true,card:'actor'},
            {id:11,category:2,name:'4',label:'朗·霍华德',ignore:true,flag:true,card:'actor'},
            {id:12,category:2,name:'5',label:'大卫·凯普',ignore:true,flag:true,card:'actor'},
            
        ],*/
        
        nodes : [
        	{id:0,category:0,name:'film',label:'${sessionScope.movieName}',ignore:false,flag:true,initial:[300,320],fixX:true,fixY:true,card:'film',},
        	<c:forEach items="${actorName}" var="realName" varStatus="statu">
	        	{id:${statu.index+1},category:1,name:'role${statu.index+1}',label:'角色${statu.index+1}',ignore:true,flag:true,},
        	</c:forEach>
	        <c:forEach items="${actorName}" var="realName" varStatus="statu">
        		{id:${fn:length(actorName) + statu.index +1},category:2,name:'演员${statu.index+1}',label:'${realName}',ignore:true,flag:true,card:'actor${statu.index+1}',},
	        </c:forEach>
        ],
/*
        links : [ 
            {source : 1,target : 0}, 
            {source : 2,target : 0}, 
            {source : 3,target : 0},
            {source : 4,target : 0}, 
            {source : 5,target : 0}, 
			{source : 6,target : 0}, 
            {source : 7,target : 1}, 
            {source : 8,target : 2}, 
            {source : 9,target : 3}, 
            {source : 10,target : 4}, 
            {source : 11,target : 5},
            {source : 12,target : 6},
        ]*/

        links : [
        	<c:forEach items="${actorName}" var="realName" varStatus="statu">
        		{source : ${statu.index+1},target : 0},
        		{source : ${fn:length(actorName) + statu.index +1},target : ${statu.index+1}}, 
        	</c:forEach>
        ]
    }]
};

(function(){
	//link 集
	var linksSet = option.series[0].links;   
	
	//节点集 
	var nodesSet = option.series[0].nodes;    
	
	//用于存放角色列表
	var roleList = [];
	
	for(var i=0;i<linksSet.length;i++){
		if(linksSet[i].target == 0){
			roleList.push(linksSet[i].source);
			}
		else continue;
		}
	//每一小份的度数
	var each = Math.PI*2/roleList.length;
	
	//alert(Math.cos(each));
	var tx;
	var ty;
	for(var i=0;i<roleList.Length;i++){
		tx = 280 + 67*Math.cos(each*(i+1));
		ty = 300 - 67*Math.sin(each*(i+1));
		nodesSet[roleList[i]].initial = [tx,ty];
		nodesSet[roleList[i]].fixX = true;
        nodesSet[roleList[i]].fixY = true;
		
		for(var j=1;j<linksSet.length;j++){
			if(linksSet[j].target == roleList[i]){
				var ttx = 280 + 270*Math.cos(each*(i+1));
				var tty = 300 - 270*Math.sin(each*(i+1));
				nodesSet[linksSet[j].source].initial = [ttx,tty];
				nodesSet[linksSet[j].source].fixX = true;
                nodesSet[linksSet[j].source].fixY = true;
				}
			}
		}
	
	})()

myChart.setOption(option);

var ecConfig = require('echarts/config');

//当鼠标点击节点，会展开该节点的延伸

function showNodes(param) {
    var data = param.data;
    if(data.flag == false){
        return false;
    }
    var option = myChart.getOption();
    var nodesOption = option.series[0].nodes;
    var linksOption = option.series[0].links;
	for(var i=1;i<nodesOption.length;i++){
		nodesOption[i].ignore = false;
		}
	
    //用于存放所选节点的子节点
/*    var linksNodes = [];
    //如果flag值为false即为不可点击
    var categoryLength = option.series[0].categories.length;
    //如果所选节点category值最小，即没有子节点，则返回，不执行下面操作
    if (data.category == (categoryLength - 1)) {
        return false;
    }

    //在控制台中打印出相关信息
    // console.log('option:'+JSON.stringify(option));
    // console.log('data:'+JSON.stringify(data));
    
    if (data != null && data != undefined) {
        //如果data值中存在id属性，即点击的是node节点
        if ('id' in data) {
            //将flag值修改为false
            data.flag = false;
            //遍历linksOption,找出所有目标为当前所选节点的结点
            //并将下一级结点的id值存放在linksNodes数组中
            for(var i = 0; i < linksOption.length ; i++){
                if(data.id == linksOption[i].target){
                    linksNodes.push(linksOption[i].source)
                }
            }
            //遍历nodesOption数组，将对应的结点的ignore属性设置为false，即展示出来
            for(var j = 0; j < linksNodes.length ; j++){
                nodesOption[linksNodes[j]].ignore = false;
            }
            //重新配置
            myChart.setOption(option);
        }
    }*/
	 myChart.setOption(option);
}

//当鼠标点击节点时，会显示该节点对应的卡片

function showCard(param) {
    var data = param.data;
    console.log(data);
    if('card' in data){
        var cards = $('.card');

        cards.hide();

        var card_current = $('#'+data.card);
        card_current[0].style.marginLeft = '0px';
        card_current.fadeIn();

        card_current.animate({marginLeft:"20px"},160);
    }   
}

myChart.on(ecConfig.EVENT.HOVER,showNodes);
myChart.on(ecConfig.EVENT.CLICK,showCard);
});
</script>