package SelCVO;

public class srchOptionVO {
	@Override
	public String toString() {
		return "srchOptionVO [location=" + location + ", cat=" + cat + ", cl=" + cl + ", dist=" + dist + ", cost="
				+ cost + ", stime=" + stime + ", etime=" + etime + "]";
	}

	private String location;
	private String cat;
	private String cl;
	private String dist;
	private String cost;
	private String stime;
	private String etime;

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
	}

	public String getCl() {
		return cl;
	}

	public void setCl(String cl) {
		this.cl = cl;
	}

	public String getDist() {
		return dist;
	}

	public void setDist(String dist) {
		this.dist = dist;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getStime() {
		return stime;
	}

	public void setStime(String stime) {
		this.stime = stime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

}
