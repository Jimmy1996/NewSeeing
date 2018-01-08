package com.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
import com.object.ActorCardInfo;

public class ActorMap {

	private String mongoIp = PathConfig.MOVIE_MONGO_HOST;
	private int mongoPort = 27017;
	private String mongoUser = PathConfig.MOVIE_MONGO_USER;
	private String mongoPwd = PathConfig.MOVIE_MONGO_PWD;
	private String mongoDBName = PathConfig.MOVIE_MONGO_DB_NAME;
	
	/**
	 * 获取电影的演员资料信息列表
	 * @param mid 电影id
	 * @return 演员资料信息列表
	 */
	public List<ActorCardInfo> getMovieActorCard(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
        
        List<ActorCardInfo> movieActor = new LinkedList<ActorCardInfo>();
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
					ActorCardInfo tagActor = new ActorCardInfo();
					tagActor.setArea((String)tagMap.get("place"));
					tagActor.setAvgBox(Creator.keepFewNum((double)tagMap.get("avg_boxOffice"), pointNum));
					tagActor.setBirthday((String)tagMap.get("brithay"));
					tagActor.setImgPath(tagMap.get("actor_img").toString().replace("../img", PathConfig.MOVIE_ACTOR_IMG_PATH));
					tagActor.setName((String)tagMap.get("actor_name"));
					tagActor.setNickName((String)tagMap.get("nick_name"));
					tagActor.setRoleName((String)tagMap.get("role_name"));
//					System.out.println(tagMap.get("place"));
//					System.out.println(tagMap.get("avg_boxOffice"));
//					System.out.println(tagMap.get("brithay"));
//					System.out.println(tagMap.get("actor_img").toString().replace("data/img", PathConfig.MOVIE_ACTOR_IMG_PATH));
//					System.out.println(tagMap.get("actor_name"));
//					System.out.println(tagMap.get("nick_name"));
//					System.out.println(tagMap.get("role_name"));
					movieActor.add(tagActor);
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return movieActor;
	}
	
	/**
	 * 根据演员资料信息列表获取电影的演员列表
	 * @param actorInfo 演员资料信息列表
	 * @return 演员列表
	 */
	public List<String> getActorName(List<ActorCardInfo> actorInfo){
		List<String> name = new LinkedList<String>();
		for(int i=0;i<actorInfo.size();i++){
			name.add(actorInfo.get(i).getName());
			System.out.println(actorInfo.get(i).getName());
		}
		return name;
	}
	
	/**
	 * 获取电影的演员演过的电影类型
	 * @param mid 电影id
	 * @return
	 */
	public List<Map<String,Double>> getMovieActorType(String mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
        
        List<Map<String,Double>> actorType = new LinkedList<Map<String,Double>>();
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
					Map<String, Double> testMap = (Map<String, Double>) tagMap.get("actor_type");
					Map<String, Double> typeMap = new HashMap<String, Double>();
					for(Map.Entry<String, Double> entry : testMap.entrySet()){
						if(entry.getValue() != 0){
							typeMap.put(entry.getKey(), entry.getValue());
						}
					}
					actorType.add(typeMap);
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return actorType;
	}
	
//	public static void main(String[] args){
//		ActorMap test = new ActorMap();
//		String mid = "579746";
//		List<ActorCardInfo> tagList = test.getMovieActorCard(mid);
//		test.getActorName(tagList);
//		List<Map<String, Double>> tag = test.getMovieActorType(mid);
//		for(int i=0;i<tag.size();i++){
//			System.out.println(i+1);
//			Map<String, Double> tagMap = tag.get(i);
//			for (Map.Entry<String, Double> entry : tagMap.entrySet()) {  
//			    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
//			} 
//		}
//	}
	
}
