package com.object;

import java.sql.Date;

public class MovieBaseInfo {
	
	public String mid;
	public String movieName;
	public String movieType;
	public String movieLength;
	public String movieBaseInfo;
	public String moviePicPath;
	public String movieMoreLink;
	public String  movieBoxOffice;
	public Date movieTime;
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	
	public String getMovieType() {
		return movieType;
	}
	public void setMovieType(String movieType) {
		this.movieType = movieType;
	}

	public String getMovieLength() {
		return movieLength;
	}
	public void setMovieLength(String movieLength) {
		this.movieLength = movieLength;
	}
	
	public String getMovieBaseInfo() {
		return movieBaseInfo;
	}
	public void setMovieBaseInfo(String movieBaseInfo) {
		this.movieBaseInfo = movieBaseInfo;
	}
	
	public String getMoviePicPath() {
		return moviePicPath;
	}
	public void setMoviePicPath(String moviePicPath) {
		this.moviePicPath = moviePicPath;
	}
	
	public String getMovieMoreLink() {
		return movieMoreLink;
	}
	public void setMovieMoreLink(String movieMoreLink) {
		this.movieMoreLink = movieMoreLink;
	}
	
	public Date getMovieTime() {
		return movieTime;
	}
	public void setMovieTime(Date movieTime) {
		this.movieTime = movieTime;
	}

	public String getMovieBoxOffice() {
		return movieBoxOffice;
	}
	public void setMovieBoxOffice(String movieBoxOffice) {
		this.movieBoxOffice = movieBoxOffice;
	}
	
}
