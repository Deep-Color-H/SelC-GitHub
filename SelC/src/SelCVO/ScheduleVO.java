package SelCVO;

import java.util.Date;

public class ScheduleVO {

	// Schedule Table에 넣을 때 필요한 것들
	int sid;
	int clid;
	String mid;
	int spreid;
	String stitle;

	// 스케쥴의 시작과 끝
	String schedule_start;
	String schedule_end;

	// 스케쥴 상단 들어갈 닉네임
	String mnick;

	
	// 스케쥴에 필요한 자료들
	String location;
	String aname;
	String aloc;
	String clname;
	String clstart;
	String clend;

	
	public ScheduleVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ScheduleVO(srchResultVO srchRes) {
		this.location = srchRes.getSlloc();
		this.mid = srchRes.getMid();
		this.clid = srchRes.getClid();
		this.schedule_start = srchRes.getSlstart();
		this.schedule_end = srchRes.getSlend();
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
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

	public int getSpreid() {
		return spreid;
	}

	public void setSpreid(int spreid) {
		this.spreid = spreid;
	}

	public String getStitle() {
		return stitle;
	}

	public void setStitle(String stitle) {
		this.stitle = stitle;
	}

	public String getSchedule_start() {
		return schedule_start;
	}

	public void setSchedule_start(String schedule_start) {
		this.schedule_start = schedule_start;
	}

	public String getSchedule_end() {
		return schedule_end;
	}

	public void setSchedule_end(String schedule_end) {
		this.schedule_end = schedule_end;
	}

	public String getMnick() {
		return mnick;
	}

	public void setMnick(String mnick) {
		this.mnick = mnick;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getClname() {
		return clname;
	}

	public void setClname(String clname) {
		this.clname = clname;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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

	public String getAloc() {
		return aloc;
	}

	public void setAloc(String aloc) {
		this.aloc = aloc;
	}

	@Override
	public String toString() {
		return "ScheduleVO [sid=" + sid + ", clid=" + clid + ", mid=" + mid + ", spreid=" + spreid + ", stitle="
				+ stitle + ", schedule_start=" + schedule_start + ", schedule_end=" + schedule_end + ", mnick=" + mnick
				+ ", location=" + location + ", aname=" + aname + ", aloc=" + aloc + ", clname=" + clname + ", clstart="
				+ clstart + ", clend=" + clend + "]";
	}
	
}
