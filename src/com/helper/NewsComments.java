package com.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import com.config.PathConfig;
import com.object.MovieNew;

public class NewsComments {

	private String ipAddress = PathConfig.MOVIE_MYSQL_HOST;
	private int port = 3306;
	private String user = PathConfig.MOVIE_MYSQL_USER;
	private String pwd = PathConfig.MOVIE_MYSQL_PWD;
	private String dbName = PathConfig.MOVIE_MYSQL_DB_NAME;
	private Connection conn = null;
	private Statement statement = null;
	
	/**
	 * 获取电影的相关新闻列表
	 * @param mid 电影id
	 * @param keyword 关键词
	 * @param resultNum 最多返回几个结果
	 * @return 相关新闻列表
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<MovieNew> getMovieNews(String mid, String keyword, int resultNum) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		String url = String.format("jdbc:mysql://%s:%s/%s?characterEncoding=utf8",this.ipAddress, this.port, this.dbName);
		this.conn = DriverManager.getConnection(url, this.user, this.pwd);
		this.statement = conn.createStatement();
		System.out.println("连接成功\n");
		
		List<MovieNew> newList = new LinkedList<MovieNew>();
		String querySql = "select * from movie_news where movie_id="+ mid + " and ( content like \"%" + keyword + "%\" or title like \"%" + keyword + "%\" ) limit " + resultNum;
		ResultSet rs = statement.executeQuery(querySql);
		System.out.println(querySql);
		while(rs.next()){
			MovieNew movie = new MovieNew();
			movie.setContent(rs.getString("content"));
			movie.setTime(rs.getString("post_time"));
			movie.setTitle(rs.getString("title"));
			movie.setWriter(rs.getString("author"));
			movie.setLink(rs.getString("address"));
			newList.add(movie);
		}
		return newList;
	}
	
	/**
	 * 获取电影的相关好评列表
	 * @param mid 电影id
	 * @param keyword 关键词
	 * @param resultNum 最多返回几个结果
	 * @return 好评列表
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<String> getGoodComments(String mid, String keyword, int resultNum) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		String url = String.format("jdbc:mysql://%s:%s/%s?characterEncoding=utf8",this.ipAddress, this.port, this.dbName);
		this.conn = DriverManager.getConnection(url, this.user, this.pwd);
		this.statement = conn.createStatement();
		System.out.println("连接成功\n");
		
		List<String> goodList = new LinkedList<String>();
		String querySql = "select * from douban_comment where movie_id="+ mid + " and content like \"%" + keyword + "%\" and score>3.0 limit " + resultNum;
		ResultSet rs = statement.executeQuery(querySql);
		System.out.println(querySql);
		while(rs.next()){
			String content = rs.getString("content");
			goodList.add(content);
			System.out.println(content);
		}
		return goodList;
	}
	
	/**
	 * 获取电影的相关差评列表
	 * @param mid 电影id
	 * @param keyword 关键词
	 * @param resultNum 最多返回几个结果
	 * @return 差评列表
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<String> getBadComments(String mid, String keyword, int resultNum) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		String url = String.format("jdbc:mysql://%s:%s/%s?characterEncoding=utf8",this.ipAddress, this.port, this.dbName);
		this.conn = DriverManager.getConnection(url, this.user, this.pwd);
		this.statement = conn.createStatement();
		System.out.println("连接成功\n");
		
		List<String> badList = new LinkedList<String>();
		String querySql = "select * from douban_comment where movie_id="+ mid + " and content like \"%" + keyword + "%\" and score<3.0 limit " + resultNum;
		ResultSet rs = statement.executeQuery(querySql);
		System.out.println(querySql);
		while(rs.next()){
			String content = rs.getString("content");
			badList.add(content);
			System.out.println(content);
		}
		return badList;
	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException{
//		NewsComments test = new NewsComments();
//		String key = "影片前戏铺排时长忍耐度极低";
//		String mid = "555839";
//		List<MovieNew> movie = test.getMovieNews(mid, key, 4);
//		for(int i=0;i<movie.size();i++){
//			System.out.println(movie.get(i).getTitle() + "\n" + movie.get(i).getContent());
//		}
//		test.getGoodComments(mid, key, 5);
//	}
	
}
