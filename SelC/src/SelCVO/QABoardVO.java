package SelCVO;

import java.util.Date;

public class QABoardVO {

	private int bid;
	private int mid;
	private String btitle;
	private String bctx;
	private Date btime;
	private int bhits;
	private String bach;
	private String mnick;
	private String bgrname;
	
	public String getMnick() {
		return mnick;
	}
	public void setMnick(String mnick) {
		this.mnick = mnick;
	}
	public String getBgrname() {
		return bgrname;
	}
	public void setBgrname(String bgrname) {
		this.bgrname = bgrname;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBctx() {
		return bctx;
	}
	public void setBctx(String bctx) {
		this.bctx = bctx;
	}
	public Date getBtime() {
		return btime;
	}
	public void setBtime(Date btime) {
		this.btime = btime;
	}
	public int getBhits() {
		return bhits;
	}
	public void setBhits(int bhits) {
		this.bhits = bhits;
	}
	public String getBach() {
		return bach;
	}
	public void setBach(String bach) {
		this.bach = bach;
	}
	@Override
	public String toString() {
		return "QABoardVO [bid=" + bid + ", mid=" + mid + ", btitle=" + btitle + ", bctx=" + bctx + ", btime=" + btime
				+ ", bhits=" + bhits + ", bach=" + bach + "]";
	}
	
	
	
}
