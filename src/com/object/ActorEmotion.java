package com.object;

public class ActorEmotion  implements Comparable<ActorEmotion>{

	private String name;
	private double good = 0;
	private double bad = 0;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getGood() {
		return good;
	}
	public void setGood(double good) {
		this.good = good;
	}
	public double getBad() {
		return bad;
	}
	public void setBad(double bad) {
		this.bad = bad;
	}
	
	@Override
	public int compareTo(ActorEmotion emotion){
		if(emotion.getGood() == 0){
			if(this.good==0){
				if(emotion.getBad() - this.bad > 0){
					return 1;
				}else{
					return -1;
				}
			}else{
				return -1;
			}
		}else{
			if(this.bad == 0){
				if((emotion.getGood() - this.good) > 0){
					return 1;
				}else{
					return -1;
				}
			}else{
				return 1;
			}
		}
	}
	
}
