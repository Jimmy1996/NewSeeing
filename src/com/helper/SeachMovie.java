package com.helper;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
import com.object.MovieBaiduIndex;
import com.object.MovieBaseInfo;
import com.object.MovieBox;

public class SeachMovie {

	private String ipAddress = PathConfig.MOVIE_MYSQL_HOST;
	private int port = 3306;
	private String user = PathConfig.MOVIE_MYSQL_USER;
	private String pwd = PathConfig.MOVIE_MYSQL_PWD;
	private String dbName = PathConfig.MOVIE_MYSQL_DB_NAME;
	private Connection conn = null;
	private Statement statement = null;
	
	private String mongoIp = PathConfig.MOVIE_MONGO_HOST;
	private int mongoPort = 27017;
	private String mongoUser = PathConfig.MOVIE_MONGO_USER;
	private String mongoPwd = PathConfig.MOVIE_MONGO_PWD;
	private String mongoDBName = PathConfig.MOVIE_MONGO_DB_NAME;
	
	/**
	 * 获取电影的基本文字信息
	 * @param mid 电影id
	 * @return 电影基本文字信息对象
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public MovieBaseInfo getMovieInfo(String mid) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		String url = String.format("jdbc:mysql://%s:%s/%s?characterEncoding=utf8",this.ipAddress, this.port, this.dbName);
		this.conn = DriverManager.getConnection(url, this.user, this.pwd);
		this.statement = conn.createStatement();
		System.out.println("连接成功\n");	
		
		MovieBaseInfo movieInfo = new MovieBaseInfo();
		movieInfo.setMid(mid);
		System.out.println("mid : " + mid);
		String querySql = "select * from movie where movie_id=" + mid;
		ResultSet rs = statement.executeQuery(querySql);
		if(rs.next()){
			String movieName = rs.getString("movie_name");
			movieInfo.setMovieName(movieName);
//			System.out.println("movieName : " +  movieName);
			
			String movieType = rs.getString("movie_type");
			movieInfo.setMovieType( movieType.replaceAll("/", "、") );
//			System.out.println("movieType : " +  movieType);
			
			String movieLength = rs.getString("length");
			movieInfo.setMovieLength(movieLength);
//			System.out.println("movieLength : " +  movieLength);
			
			String movieBaseInfo = rs.getString("story");
			movieInfo.setMovieBaseInfo(movieBaseInfo);
//			System.out.println("movieBaseInfo : " +  movieBaseInfo);
			
			String moviePicPath = rs.getString("post_src");
			//(new PinYin().HanyuToPinyin(moviePicPath))
			movieInfo.setMoviePicPath(moviePicPath.replace("/home/iiips/imgs", PathConfig.MOVIE_IMG_PATH));
//			System.out.println("moviePicPath: " + moviePicPath);
			
			String movieMoreLink = rs.getString("baike_link");
			movieInfo.setMovieMoreLink(movieMoreLink);
//			System.out.println("movieMoreLink: " + movieMoreLink);
			
			Date movieTime = rs.getDate("release_time");
			movieInfo.setMovieTime(movieTime);
//			System.out.println("movieTime : " +  movieTime);
			
			Double movieBoxOffice = rs.getDouble("box_office");
			movieInfo.setMovieBoxOffice(Double.toString(movieBoxOffice) + "万");
//			System.out.println("movieBoxOffice : " + movieBoxOffice);
			
		}else{
			System.out.println("没有找到这部电影");
		}
		
		return movieInfo;
	}
	
	/**
	 * 获取电影的各网站评分
	 * @param mid 电影id
	 * @return Map<某网站,网站评分>
	 */
	public Map<String,Double> getMovieScores(int mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
        
		Map<String,Double> scores = new HashMap<String,Double>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("movie_info");
		 BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Object> tag = (Map<String, Object>) map.get("movie_info");
				double weiboScore = (double) tag.get("weibo_score");
				double doubanScore = (double) tag.get("douban_score");
				double mtimeScore = (double) tag.get("mtime_score");
				System.out.println("weiboScore " + weiboScore);
				System.out.println("doubanScore " + doubanScore);
				System.out.println("mtimeScore " + mtimeScore);
				scores.put("weiboScore", weiboScore);
				scores.put("doubanScore", doubanScore);
				scores.put("mtimeScore", mtimeScore);
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return scores;
	}
	
	/**
	 * 获取电影的票房走势
	 * @param mid 电影id
	 * @return [[第几周,票房],...]
	 */
	public List<MovieBox> getMovieBox(int mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
        
        List<MovieBox> movieBox = new LinkedList<MovieBox>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("movie_info");
		 BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Object> tag = (Map<String, Object>) map.get("movie_info");
				List<List<String>>box = (List<List<String>>) tag.get("boxOffice");
				for(int i=0;i<box.size();i++){
					MovieBox tagBox = new MovieBox();
					tagBox.setWeek(box.get(i).get(0));
					tagBox.setBox(box.get(i).get(1));
					movieBox.add(tagBox);
//					System.out.println(i+1);
//					System.out.println(box.get(i).get(0));
//					System.out.println(box.get(i).get(1));
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return movieBox;
	}
	
	/**
	 * 获取电影的百度搜索指数
	 * @param mid 电影id
	 * @return [[日期,搜索指数],...]
	 */
	public List<MovieBaiduIndex> getMovieIndex(int mid){
		ServerAddress serverAddress = new ServerAddress(mongoIp, mongoPort);  
        List<ServerAddress> addrs = new ArrayList<ServerAddress>();  
        addrs.add(serverAddress);  
        MongoCredential credential = MongoCredential.createCredential(mongoUser, mongoDBName, mongoPwd.toCharArray());  
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();  
        credentials.add(credential);  
        MongoClient mongoClient = new MongoClient(addrs,credentials);  
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBName); 
        
        List<MovieBaiduIndex> movieIndex = new LinkedList<MovieBaiduIndex>();
		MongoCollection<Document> doc = mongoDatabase.getCollection("movie_info");
		 BasicDBObject query = new BasicDBObject("_id", mid);
		FindIterable<Document> iterable = doc.find(query);
		MongoCursor<Document> cursor = iterable.iterator();
		try{
			while(cursor.hasNext()){
				Document movie = cursor.next();
				String jsonStr = movie.toJson();
				Object parseObj = JSON.parse(jsonStr); // 反序列化 把json 转化为对象
				Map<String,Object> map = (HashMap<String,Object>) parseObj; // 把对象转化为map
				Map<String,Object> tag = (Map<String, Object>) map.get("movie_info");
				List<List<Object>> index = (List<List<Object>>) tag.get("baidu_index_list");
				for(int i=0;i<index .size();i++){
					MovieBaiduIndex tagIndex = new MovieBaiduIndex();
					tagIndex.setDate((String)index.get(i).get(0));
					tagIndex.setNum((int)index.get(i).get(1));
					movieIndex.add(tagIndex);
//					System.out.println(i+1);
//					System.out.println(index.get(i).get(0));
//					System.out.println(index.get(i).get(1));
				}
			}
		}finally{
			cursor.close();
		}
		mongoClient.close();
		return movieIndex;
	}
	
	//确定百度指数图表的纵坐标最大值
	public int getMaxNum(List<MovieBaiduIndex> index){
		int max = 0;
		for(int i=0;i<index.size();i++){
			if(index.get(i).getNum() > max){
				max = index.get(i).getNum();
			}
		}
		int num = (max / 1000 +2) *1000;
		return num;
	}
	
//	public static void main(String[] args){
//		int mid = 588160;
//		SeachMovie test =  new SeachMovie();
//		test.getMovieIndex(mid);
//	}

}
