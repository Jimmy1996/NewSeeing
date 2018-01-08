package com.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.bson.Document;

import com.config.PathConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;
import com.object.ActorAward;
import com.object.ActorEmotion;
import com.object.ActorOtherImpact;
import com.object.ActorScoreAndBox;
import com.object.ActorWeibo;

public class Creator {
	
	private String mongoIp = PathConfig.MOVIE_MONGO_HOST;
	private int mongoPort = 27017;
	private String mongoUser = PathConfig.MOVIE_MONGO_USER;
	private String mongoPwd = PathConfig.MOVIE_MONGO_PWD;
	private String mongoDBName = PathConfig.MOVIE_MONGO_DB_NAME;
	
	/**
	 * 获取某电影演员的提名及获奖情况
	 * @param mid 电影id
	 * @return
	 */
	public List<ActorAward> getActorAward(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
		List<ActorAward> actor = new LinkedList<ActorAward>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_price");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				List<Map<String,Object>> tag = (List<Map<String,Object>>) map.get("actor_list");
				for(int i=0;i<tag.size();i++){
					Map<String,Object> tagMap = (Map<String, Object>) tag.get(i);
					if( ((int)tagMap.get("price_num") != 0) || ((int)tagMap.get("nomination_num") != 0) ){
						ActorAward tagActor = new ActorAward();
						tagActor.setName((String)tagMap.get("actor_name"));
						tagActor.setNomination((int)tagMap.get("nomination_num"));
						tagActor.setPrice((int)tagMap.get("price_num"));
//						System.out.println(tagMap.get("actor_name"));
//						System.out.println(tagMap.get("nomination_num"));
//						System.out.println(tagMap.get("price_num"));
						actor.add(tagActor);
					}
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actor;
	}
	
	/**
	 * 获取某电影演员的微博号召力
	 * @param mid 电影id
	 * @return
	 */
	public List<ActorWeibo> getActorWeibo(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
		List<ActorWeibo> actor = new LinkedList<ActorWeibo>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_weibo");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				List<Map<String,Object>> tag = (List<Map<String,Object>>) map.get("actor_list");
				for(int i=0;i<tag.size();i++){
					Map<String,Object> tagMap = (Map<String, Object>) tag.get(i);
					if((int)tagMap.get("weibo_num") != 0){
						ActorWeibo tagActor = new ActorWeibo();
						tagActor.setName((String)tagMap.get("actor_name"));
						tagActor.setActive((int)tagMap.get("active"));
						tagActor.setFanNum((int)tagMap.get("fans_num"));
						tagActor.setFollowNum((int)tagMap.get("follow_num"));
						tagActor.setInfluence((int)tagMap.get("influence"));
						tagActor.setWeiboNum((int)tagMap.get("weibo_num"));
//						System.out.println(tagMap.get("actor_name"));
//						System.out.println(tagMap.get("active"));
//						System.out.println(tagMap.get("fans_num"));
//						System.out.println(tagMap.get("follow_num"));
//						System.out.println(tagMap.get("influence"));
//						System.out.println(tagMap.get("weibo_num"));
						actor.add(tagActor);
					}
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actor;
	}
	
	/**
	 * 获取某电影演员的百度搜索指数
	 * @param mid 电影id
	 * @return
	 */
	public Map<String,List<Object>> getActorBaidu(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
        Map<String,List<Object>> actor = new HashMap<String,List<Object>>();
        List<Object> actorName = new LinkedList<Object>();
        List<Object> actorIndex = new LinkedList<Object>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_baiduIndex");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String, Integer> tag =(Map<String, Integer>) map.get("actor_baidu_index");
				for (Map.Entry<String, Integer> entry : tag.entrySet()) {  
//				    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
					if(entry.getValue() != 0){
						 actorName.add(entry.getKey());
						 actorIndex.add(entry.getValue());
					}
				}
			}
		}finally{
			cursor.close();
		}
		actor.put("actorName", actorName);
		actor.put("actorIndex", actorIndex);
		mongoClient.close();
		return actor;
	}
	
	/**
	 * 获取某电影演员的豆瓣评分与票房
	 * @param mid 电影id
	 * @return
	 */
	public List<ActorScoreAndBox> getActorScoreAndBox(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
		List<ActorScoreAndBox> actor = new LinkedList<ActorScoreAndBox>();
		int pointNum = 3;
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_graph");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				List<Map<String,Object>> tag = (List<Map<String,Object>>) map.get("actor_list");
				for(int i=0;i<tag.size();i++){
					Map<String,Object> tagMap = (Map<String, Object>) tag.get(i);
					ActorScoreAndBox tagActor = new ActorScoreAndBox();
					tagActor.setName((String)tagMap.get("actor_name"));
					tagActor.setBox(Creator.keepFewNum((double)tagMap.get("avg_boxOffice"), pointNum));
//					System.out.println(tagMap.get("actor_name"));
//					System.out.println(tagMap.get("avg_boxOffice"));
					actor.add(tagActor);
				}
			}
		
			doc = mongoDatabase.getCollection("actor_doubanScore");
			query = new BasicDBObject("_id", mid);
			iterable = doc.find(query);
			cursor = iterable.iterator();
		
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Double> tag = (Map<String,Double>) map.get("actor_douban_score");
				for (Map.Entry<String, Double> entry : tag.entrySet()) {  
//				    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
				    for(int i=0;i<actor.size();i++){
				    	if(entry.getKey().equals(actor.get(i).getName())){
				    		actor.get(i).setScore(Creator.keepFewNum(entry.getValue(), pointNum));
//				    		System.out.println(actor.get(i).getScore());
				    		break;
				    	}
				    }
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		
		for(int i=0;i<actor.size();i++){
			if((actor.get(i).getScore() == 0) && (actor.get(i).getBox() == 0)){
				actor.remove(i);
			}
		}
		
		return actor;
	}
	
	/**
	 * 获取某电影演员的历史票房
	 * @param mid 电影id
	 * @return
	 */
	public Map<String,List<Integer>> getActorHistoryBox(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
        Map<String,List<Integer>> actor = new HashMap<String,List<Integer>>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_boxOffice");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,List<Double>> tag = (Map<String,List<Double>>) map.get("actor_boxOffice");
				for (Map.Entry<String, List<Double>> entry : tag.entrySet()) {
					if(entry.getValue().size() == 0){
						continue;
					}
				    List<Integer> testList = new LinkedList<Integer>();
				    for(int i=0;i<12;i++){
				    	testList.add(0);
				    }
				    List<Double> tagList = entry.getValue();
//				    System.out.println(entry.getKey());
				    for(int i=0;i<tagList.size();i++){
				    	double tagNum = tagList.get(i);
//				    	System.out.println(tagNum);
				    	if(tagNum < 1){ //小于1万
				    		testList.set(0, testList.get(0) + 1);
				    	}else if(tagNum < 10){//1-10万
				    		testList.set(1, testList.get(1) + 1);
				    	}else if(tagNum < 50){//10-50万
				    		testList.set(2, testList.get(2) + 1);
				    	}else if(tagNum < 100){//50-100万
				    		testList.set(3, testList.get(3) + 1);
				    	}else if(tagNum < 500){//100-500万
				    		testList.set(4, testList.get(4) + 1);
				    	}else if(tagNum < 1000){//500-1000万
				    		testList.set(5, testList.get(5) + 1);
				    	}else if(tagNum < 5000){//1000-5000万
				    		testList.set(6, testList.get(6) + 1);
				    	}else if(tagNum < 10000){//5000万-1亿
				    		testList.set(7, testList.get(7) + 1);
				    	}else if(tagNum < 100000){//1-10亿
				    		testList.set(8, testList.get(8) + 1);
				    	}else if(tagNum < 500000){//10-50亿
				    		testList.set(9, testList.get(9) + 1);
				    	}else if(tagNum < 1000000){//50-100亿
				    		testList.set(10, testList.get(10) + 1);
				    	}else{//大于等于100亿
				    		testList.set(11, testList.get(11) + 1);
				    	}
				    }
				    actor.put(entry.getKey(), testList);
				}
				
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actor;
	}
	
	/**
	 * 获取某电影演员的其他影响指标
	 * @param mid 电影id
	 * @return
	 */
	public List<ActorOtherImpact> getActorOtherImpart(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
		List<ActorOtherImpact> actor = new LinkedList<ActorOtherImpact>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_fans_love");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Double> tag = (Map<String,Double>) map.get("actor_fans_love");
				Set<String> nameSet = tag.keySet();
				double loveSum = 0;
				for(String name : nameSet){
					if( tag.get(name) > loveSum){
						loveSum = tag.get(name);
					}
				}
				for (Map.Entry<String, Double> entry : tag.entrySet()) {
					if(entry.getValue() != 0){
						ActorOtherImpact tagActor = new ActorOtherImpact();
						tagActor.setName(entry.getKey());
						tagActor.setLove(entry.getValue()/loveSum);
						actor.add(tagActor);
					}
				}
			}
		
			doc = mongoDatabase.getCollection("actor_newpercentages");
			query = new BasicDBObject("_id", mid);
			iterable = doc.find(query);
		    cursor = iterable.iterator();
		    
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Double> tag = (Map<String,Double>) map.get("actor_newpercentages");
				Set<String> nameSet = tag.keySet();
				for(int i=0;i<actor.size();i++){
					String actorName = actor.get(i).getName();
					if(nameSet.contains(actorName)){
						actor.get(i).setCover(tag.get(actorName));
					}
				}
			}
		
			doc = mongoDatabase.getCollection("actor_match_type");
			query = new BasicDBObject("_id", mid);
			iterable = doc.find(query);
		    cursor = iterable.iterator();
		
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,String> tag = (Map<String,String>) map.get("actor_match_type");
				Set<String> nameSet = tag.keySet();
				for(int i=0;i<actor.size();i++){
					String actorName = actor.get(i).getName();
					if(nameSet.contains(actorName)){
						actor.get(i).setMatch(Double.valueOf(tag.get(actorName)));
					}
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actor;
	}
	
	/**
	 * 获取某电影演员的好差评涉及率
	 * @param mid 电影id
	 * @return
	 */
	public List<ActorEmotion> getActorEmotion(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
		List<ActorEmotion> actor = new LinkedList<ActorEmotion>();
		int pointNum = 3;
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_emotion_score");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Double> tag = (Map<String, Double>) map.get("actor_emotion_score");
				for (Map.Entry<String, Double> entry : tag.entrySet()) {
//					System.out.println(entry.getKey() + " : " + entry.getValue());
					if(entry.getValue() != 0){
						ActorEmotion tagActor = new ActorEmotion();
						tagActor.setName(entry.getKey());
						if(entry.getValue() > 0){
							tagActor.setGood(Creator.keepFewNum(entry.getValue(), pointNum));
						}else{
							tagActor.setBad(Creator.keepFewNum(entry.getValue(), pointNum));
						}
						actor.add(tagActor);
					}
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		Collections.sort(actor);
		return actor;
	}
	
	/**
	 * 获取某电影演员的总体排行榜
	 * @param mid 电影id
	 * @return
	 */
	public Map<String,List<Map<String, Object>>> getActorTotal(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
        Map<String,List<Map<String, Object>>>  actorTotal = new HashMap<String,List<Map<String, Object>>>();
        int pointNum = 3;
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_totallist");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Integer> tag = (Map<String, Integer>) map.get("weibo");
				List<Map<String, Object>> totalTag = new ArrayList<Map<String, Object>>();
				double sumTag = 0.0;
				for (Map.Entry<String,Integer> entry : tag.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((int)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("微博影响力",  totalTag);
				
				sumTag = 0.0;
				Map<String, Double> tag2 = (Map<String, Double>) map.get("newpercentages");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), Creator.keepFewNum(entry.getValue(), pointNum));
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("媒体提及率", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("match_type");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("电影匹配度", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("price");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("获奖情况", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("fans_love");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("粉丝喜好度", totalTag);
				
				sumTag = 0.0;
				tag = (Map<String, Integer>) map.get("baiduIndex");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Integer> entry : tag.entrySet()) { 
					if((entry.getValue() * 1.0) != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((int)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("百度搜索指数", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("emotion_score");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("评论涉及率", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("doubanScore");
				totalTag = new ArrayList<Map<String, Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) { 
					if(entry.getValue() != 0){
						sumTag += entry.getValue();
						Map<String, Object> tagMap = new HashMap<String, Object>();
						tagMap.put(entry.getKey(), entry.getValue());
						totalTag.add(tagMap);
					}
				}
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("豆瓣评分", totalTag);
				
				sumTag = 0.0;
				tag2 = (Map<String, Double>) map.get("coef");
				totalTag = new ArrayList<Map<String,Object>>();
				for (Map.Entry<String,Double> entry : tag2.entrySet()) {  
				    String name = entry.getKey() ;
				    if(entry.getValue() == 0){
				    	sumTag += 0.001;
				    }else{
				    	sumTag += entry.getValue();
				    }
				    if(name.equals("doubanScore")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("豆瓣评分", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("豆瓣评分", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("weibo")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("微博影响力", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("微博影响力", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("newpercentages")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("媒体提及率", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("媒体提及率", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("match_type")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("电影匹配度", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("电影匹配度", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("fans_love")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("粉丝喜好度", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("粉丝喜好度", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("price")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("获奖情况", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("获奖情况", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("baiduIndex")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("百度搜索指数", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("百度搜索指数", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("boxOffice")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("电影票房", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("电影票房", 0.001);
							totalTag.add(tagMap);
				    	}
				    }else if(name.equals("emotion_score")){
				    	if(entry.getValue() != 0){
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("评论涉及率", entry.getValue());
							totalTag.add(tagMap);
				    	}else{
				    		Map<String, Object> tagMap = new HashMap<String, Object>();
							tagMap.put("评论涉及率", 0.001);
							totalTag.add(tagMap);
				    	}
				    }
				} 
				Collections.sort(totalTag, new MapComparatorDesc());
				for(int i=0;i<totalTag.size();i++){
					for(Map.Entry<String, Object> entry:totalTag.get(i).entrySet()){
						entry.setValue(Creator.keepFewNum((double)entry.getValue()/sumTag, pointNum));
					}
				}
				actorTotal.put("total", totalTag);
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actorTotal;
	}
	
	/**
	 * 获取某电影演员的贡献榜
	 * @param mid 电影id
	 * @return
	 */
	public List<Map<String,Object>> getActorContribution(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
		
        List<Map<String,Object>> actor = new ArrayList<Map<String,Object>>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("actor_attribute");
		BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Double> tag = (Map<String,Double>) map.get("actot_attribute");
				for(Map.Entry<String,Double> entry : tag.entrySet()){
					Map<String,Object> tagMap = new HashMap<String,Object>();
					if(entry.getValue() != 0){
						tagMap.put(entry.getKey(), entry.getValue());
						actor.add(tagMap);
					}
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		Collections.sort(actor, new MapComparatorDesc());
		return actor;
	}
	
	/**
	 * 获取某电影的演员豆瓣评分和平均票房的纵坐标最大值
	 * @param objects
	 * @return
	 */
	public double getMaxNum(List<ActorScoreAndBox> objects){
		double tag = 0;
		for(int i=0;i<objects.size();i++){
			if(tag < objects.get(i).getBox()){
				tag = objects.get(i).getBox();
			}
		}
		double num = (tag / 1000 + 2) * 1000;
		return num;
	}

	/**
	 * 使某浮点数保留小数点后几位
	 * @param num 某浮点数
	 * @param pointNum 保留几位
	 * @return
	 */
	public static double keepFewNum(double num, int pointNum){
		double point = Math.pow(10, pointNum);
		return Math.round(num*point)/point;
	}
	
	//降序
	public static class MapComparatorDesc implements Comparator<Map<String, Object>> {
        @Override
        public int compare(Map<String, Object> m1, Map<String, Object> m2) {
        	Double v1 = 0.0;
        	for (Map.Entry<String,Object> entryTag : m1.entrySet()) { 
        		 v1 = Double.valueOf(entryTag.getValue().toString());
        	}
        	Double v2 = 0.0;
        	for (Map.Entry<String,Object> entryTag : m2.entrySet()) { 
        		 v2 = Double.valueOf(entryTag.getValue().toString());
        	}
            if (v2 != null) {
                return v2.compareTo(v1);
            }
            return 0;
        }
  
    }
	
	
	public static void main(String[] args){
//		Creator test = new Creator();
//		System.out.println(test.keepFewNum(1.2365987, 3));
//		String mid = "628157";
//		Map<String,List<Map<String,Object>>> tag = test.getActorTotal(mid);
//		for (Map.Entry<String,List<Map<String,Object>>> entry : tag.entrySet()) {  
//			System.out.println(entry.getKey());
//			List<Map<String,Object>> tagMap = entry.getValue();
//			for(int i=0;i<tagMap.size();i++){
//				System.out.println(i+1);
//				Map<String,Object> tagL = tagMap.get(i);
//				for(Map.Entry<String, Object> tagE: tagL.entrySet()){
//					System.out.println(tagE.getKey() + ": " + tagE.getValue().toString());
//				}
//			}
//		}
//		List<Map<String,Object>> tag = test.getActorContribution(mid);
//		System.out.println("len: " + tag.size());
//		for(int i=0;i<tag.size();i++){
//			System.out.println(i+1);
//			for(Map.Entry<String, Object> entry:tag.get(i).entrySet()){
//				System.out.println(entry.getKey() + ": " + entry.getValue());
//			}
//		}
	}
	
}
