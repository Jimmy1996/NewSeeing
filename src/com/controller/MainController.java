package com.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.lucene.queryparser.classic.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.helper.ActorMap;
import com.helper.Creator;
import com.helper.NewsComments;
import com.helper.SeachMovie;
import com.lucene.MainLuceneSearcher;
import com.object.ActorAward;
import com.object.ActorCardInfo;
import com.object.ActorEmotion;
import com.object.ActorOtherImpact;
import com.object.ActorScoreAndBox;
import com.object.ActorWeibo;
import com.object.MovieBaiduIndex;
import com.object.MovieBaseInfo;
import com.object.MovieBox;
import com.object.MovieNew;

@Controller
public class MainController {
	
	private List<ActorAward> award;
	private List<ActorWeibo> weibo;
	private Map<String,List<Object>> baidu;
	private List<ActorScoreAndBox> scoreAndBox;
	private Map<String,List<Integer>> history;
	private List<ActorOtherImpact> other;
	private List<ActorEmotion> emotion;
	private Map<String,List<Map<String,Object>>> total;
	private List<Map<String,Object>> contribution;
	private double max;
	
	@RequestMapping(value="/index")
	public String index(@RequestParam(value="errorInfo", required=false)String errorInfo, Model model) throws UnsupportedEncodingException{
//		System.out.println("errorInfo: " + errorInfo);
//		errorInfo = new String(errorInfo.getBytes("iso-8859-1"), "UTF-8");
		if(errorInfo != "null"){
			model.addAttribute("errorInfo", errorInfo);
			System.out.println("error: " + errorInfo);
		}
		return "index";
	}
	
	@RequestMapping(value="/searchMovie")
	public String seachMovie(HttpServletRequest request,@RequestParam(value="movieName")String movieName,Model model) throws ParseException, IOException{
		List<String> mid = MainLuceneSearcher.getMovieIdByName(movieName, 1);
		if(mid.size() == 0){
			String error = "没有找到相关电影";
			model.addAttribute("errorInfo", error);
			return "redirect:/index.action";
		}
		HttpSession session = request.getSession();
		session.setAttribute("mid", mid.get(0));
		return "redirect:/movieInfo.action";
	}
	
	@RequestMapping(value="/movieInfo")
	public String showMovieInfoPage(HttpServletRequest request,Model model) throws ClassNotFoundException, SQLException{
		HttpSession session = request.getSession();
		String mid = "";
		try{
			mid = session.getAttribute("mid").toString();
		}catch (NullPointerException e){
			String error = "请搜索电影";
			model.addAttribute("errorInfo", error);
			return "redirect:/index.action";
		}
			
		SeachMovie seach = new SeachMovie();
		MovieBaseInfo movieInfo =  seach.getMovieInfo(mid);
		session.setAttribute("movieName", movieInfo.getMovieName());
		model.addAttribute("movieInfo", JSON.toJSON(movieInfo));
		Map<String,Double> map = seach.getMovieScores(Integer.valueOf(mid).intValue());
		for (String key : map.keySet()) {
			   model.addAttribute(key, map.get(key));
		}
		List<MovieBox> movieBox = seach.getMovieBox(Integer.valueOf(mid).intValue());
		model.addAttribute("movieBox", movieBox);
		List<MovieBaiduIndex> movieBaiduIndex = seach.getMovieIndex(Integer.valueOf(mid).intValue());
		model.addAttribute("movieBaiduIndex", movieBaiduIndex);
		int maxOrdinate = seach.getMaxNum(movieBaiduIndex);
		model.addAttribute("maxOrdinate", maxOrdinate);
//		System.out.println("baidu max : " + maxOrdinate);
		return "essential_Information";
	}
	
	@RequestMapping(value="/movieActor")
	public String showMovieActors(HttpServletRequest request,Model model) throws ParseException, IOException{
		HttpSession session = request.getSession();
		String mid = "";
		try{
			mid = session.getAttribute("mid").toString();
		}catch (NullPointerException e){
			String error = "请搜索电影";
			model.addAttribute("errorInfo", error);
			return "redirect:/index.action";
		}
		
		ActorMap actor = new ActorMap();
		List<ActorCardInfo> actorCardInfo = actor.getMovieActorCard(mid);
		model.addAttribute("actorCardInfo", actorCardInfo);
		List<String> actorName = actor.getActorName(actorCardInfo);
		model.addAttribute("actorName", actorName);
		List<Map<String,Double>> actorMovieType = actor.getMovieActorType(mid);
		model.addAttribute("actorMovieType", actorMovieType);
		return "actorMap";
	}
	
	@RequestMapping(value="/movieGraph")
	public String showMovieGraph(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		String mid = "";
		try{
			mid = session.getAttribute("mid").toString();
		}catch (NullPointerException e){
			String error = "请搜索电影";
			model.addAttribute("errorInfo", error);
			return "redirect:/index.action";
		}
		
		Creator create = new Creator();
		List<ActorAward> actorAward = create.getActorAward(mid);
		model.addAttribute("actorAward", actorAward);
		this.award = actorAward;
		List<ActorWeibo> actorWeibo = create.getActorWeibo(mid);
		model.addAttribute("actorWeibo", actorWeibo);
		this.weibo = actorWeibo;
		Map<String,List<Object>> actorBaidu = create.getActorBaidu(mid);
		model.addAttribute("actorName", actorBaidu.get("actorName"));
		model.addAttribute("actorIndex", actorBaidu.get("actorIndex"));
		this.baidu = actorBaidu;
		List<ActorScoreAndBox> actorScore = create.getActorScoreAndBox(mid);
		double maxOrdinate = create.getMaxNum(actorScore);
		model.addAttribute("actorScore", actorScore);
		model.addAttribute("maxOrdinate", maxOrdinate);
//		System.out.println("box max: " + maxOrdinate);
		this.scoreAndBox = actorScore;
		this.max = maxOrdinate;
		Map<String,List<Integer>> actorHistoryBox = create.getActorHistoryBox(mid);
		model.addAttribute("actorHistoryBox", actorHistoryBox);
		this.history = actorHistoryBox;
		List<ActorOtherImpact> actorOtherImpact = create.getActorOtherImpart(mid);
		model.addAttribute("actorOtherImpact", actorOtherImpact);
		this.other = actorOtherImpact;
		List<ActorEmotion> actorEmotion = create.getActorEmotion(mid);
		model.addAttribute("actorEmotion", actorEmotion.subList(0, 6));
		this.emotion = actorEmotion;
		Map<String,List<Map<String,Object>>> actorTotal = create.getActorTotal(mid);
		model.addAttribute("actorTotal", actorTotal);
		this.total = actorTotal;
		List<Map<String,Object>> actorContribution = create.getActorContribution(mid);
		model.addAttribute("actorContribution", actorContribution.subList(0, 6));
		this.contribution = actorContribution;
		return "creatorContribution";
	}
	
	@RequestMapping(value="/movieGraph/{graphName}")
	public String showMovieGraphDetail(@PathVariable("graphName")String graphName,HttpServletRequest request,Model model) {
		if(graphName.equals("actorAward")){
			model.addAttribute("actorAward", this.award);
		}else if(graphName.equals("microBlogAppeal")){
			model.addAttribute("actorWeibo", this.weibo);
		}else if(graphName.equals("baiduSearch")){
			model.addAttribute("actorName", this.baidu.get("actorName"));
			model.addAttribute("actorIndex", this.baidu.get("actorIndex"));
		}else if(graphName.equals("boxOffice_douBanScore")){
			model.addAttribute("actorScore", this.scoreAndBox);
			model.addAttribute("maxOrdinate", this.max);
		}else if(graphName.equals("historicalBoxOffice")){
			model.addAttribute("actorHistoryBox", this.history);
		}else if(graphName.equals("otherImpactTarget")){
			model.addAttribute("actorOtherImpact", this.other);
		}else if(graphName.equals("reviewRate")){
			model.addAttribute("actorEmotion", this.emotion);
		}else if(graphName.equals("overallRanking")){
			model.addAttribute("actorTotal", this.total);
		}else if(graphName.equals("creatContributeList")){
			model.addAttribute("actorContribution", contribution);
		}
		System.out.println(graphName);
		return "creatorContribution/" + graphName;
	}
	
	@RequestMapping(value="/movieNew")
	public String showMovieNews(HttpServletRequest request,Model model) throws ParseException, IOException{
		return "newsMessage";
	}
	
	@RequestMapping(value="/movieNewDetail", method=RequestMethod.POST)
	public String showMovieNewsDetail(HttpServletRequest request,@RequestParam(value="searchKey")String searchKey,Model model) throws ParseException, IOException, ClassNotFoundException, SQLException{
		HttpSession session = request.getSession();
		String mid = "";
		try{
			mid = session.getAttribute("mid").toString();
		}catch (NullPointerException e){
			String error = "请搜索电影";
			model.addAttribute("errorInfo", error);
			return "redirect:/index.action";
		}
		
		int resultNum = 8;
		NewsComments newAndComment = new NewsComments();
		List<MovieNew> movieNew = newAndComment.getMovieNews(mid, searchKey, resultNum);
		model.addAttribute("movieNew", movieNew);
		List<String> goodNews = newAndComment.getGoodComments(mid, searchKey, resultNum);
		model.addAttribute("goodNews", goodNews);
		List<String> badNews = newAndComment.getBadComments(mid, searchKey, resultNum);
		model.addAttribute("badNews", badNews);
		return "newsMessage";
	}
	
	public static void main(String[] args){

	}

}
