package SelCVO;

import java.util.Date;

public class srchResultVO {

	private int slid;
	private String slloc;
	private String acatid;
	private String clcatid;
	private String sldist;
	private String slcost;
	private String slstart;
	private String slend;

	private int clid;

	private String mid;
	private int spreid;

	public int getSpreid() {
		return spreid;
	}

	public void setSpreid(int spreid) {
		this.spreid = spreid;
	}

	public int getClid() {
		return clid;
	}

	public void setClid(int clid) {
		this.clid = clid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public int getSlid() {
		return slid;
	}

	public void setSlid(int slid) {
		this.slid = slid;
	}

	public String getSlloc() {
		return slloc;
	}

	public void setSlloc(String slloc) {
		this.slloc = slloc;
	}

	public String getAcatid() {
		return acatid;
	}

	public void setAcatid(String acatid) {
		this.acatid = acatid;
	}

	public String getClcatid() {
		return clcatid;
	}

	public void setClcatid(String clcatid) {
		this.clcatid = clcatid;
	}

	public String getSldist() {
		return sldist;
	}

	public void setSldist(String sldist) {
		this.sldist = sldist;
	}

	public String getSlcost() {
		return slcost;
	}

	public void setSlcost(String slcost) {
		this.slcost = slcost;
	}

	public String getSlstart() {
		return slstart;
	}

	public void setSlstart(String slstart) {
		this.slstart = slstart;
	}

	public String getSlend() {
		return slend;
	}

	public void setSlend(String slend) {
		this.slend = slend;
	}

	@Override
	public String toString() {
		return "srchResultVO [clid=" + clid + ", mid=" + mid + ", slid=" + slid + ", slloc=" + slloc + ", acatid="
				+ acatid + ", clcatid=" + clcatid + ", sldist=" + sldist + ", slcost=" + slcost + ", slstart=" + slstart
				+ ", slend=" + slend + "]";
	}

}
