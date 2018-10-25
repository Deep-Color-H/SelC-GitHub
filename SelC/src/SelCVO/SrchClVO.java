package SelCVO;

import java.text.SimpleDateFormat;

public class SrchClVO {

	private int aid;
	private String aname;
	private String aloc;
	private int clid;
	private String clname;
	private int clday;
	private String clstart;
	private String clend;
	private int ccost;

	SimpleDateFormat sdmt = new SimpleDateFormat("kk:mm");

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getAloc() {
		return aloc;
	}

	public void setAloc(String aloc) {
		this.aloc = aloc;
	}

	public int getClid() {
		return clid;
	}

	public void setClid(int clid) {
		this.clid = clid;
	}

	public String getClname() {
		return clname;
	}

	public void setClname(String clname) {
		this.clname = clname;
	}

	public int getClday() {
		return clday;
	}

	public void setClday(int clday) {
		this.clday = clday;
	}

	public String getClstart() {
		return clstart;
	}

	public void setClstart(String clstart) {
		this.clstart = clstart;
	}

	public String getClend() {
		return clend;
	}

	public void setClend(String clend) {
		this.clend = clend;
	}

	public int getCcost() {
		return ccost;
	}

	public void setCcost(int ccost) {
		this.ccost = ccost;
	}

	@Override
	public String toString() {
		return "SrchClVO [aid=" + aid + ", aname=" + aname + ", aloc=" + aloc + ", clid=" + clid + ", clname=" + clname
				+ ", clday=" + clday + ", clstart=" + clstart + ", clend=" + clend + ", ccost=" + ccost + "]";
	}


}
