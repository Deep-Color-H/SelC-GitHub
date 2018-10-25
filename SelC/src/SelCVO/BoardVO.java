package SelCVO;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private int bid;
	private String bcatid;
	private int mid;
	private int sid;
	private String btitle;
	private String bctx;
	private Date btime;
	private int brcm;
	private int bhits;
	private String bimg;
	private String mnick;
	private String bgrname;
	private MultipartFile bimg_org;

	public MultipartFile getBimg_org() {
		return bimg_org;
	}

	public void setBimg_org(MultipartFile bimg_org) {
		this.bimg_org = bimg_org;
	}

	public String getBgrname() {
		return bgrname;
	}

	public void setBgrname(String bgrname) {
		this.bgrname = bgrname;
	}

	public String getMnick() {
		return mnick;
	}

	public void setMnick(String mnick) {
		this.mnick = mnick;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getBcatid() {
		return bcatid;
	}

	public void setBcatid(String bcatid) {
		this.bcatid = bcatid;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
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

	public int getBrcm() {
		return brcm;
	}

	public void setBrcm(int brcm) {
		this.brcm = brcm;
	}

	public int getBhits() {
		return bhits;
	}

	public void setBhits(int bhits) {
		this.bhits = bhits;
	}

	public String getBimg() {
		return bimg;
	}

	public void setBimg(String bimg) {
		this.bimg = bimg;
	}

	@Override
	public String toString() {
		return "BoardVO [bid=" + bid + ", bcatid=" + bcatid + ", mid=" + mid + ", sid=" + sid + ", btitle=" + btitle
				+ ", bctx=" + bctx + ", btime=" + btime + ", brcm=" + brcm + ", bhits=" + bhits + ", bimg=" + bimg
				+ ", mnick=" + mnick + ", bgrname=" + bgrname + ", bimg_org=" + bimg_org + "]";
	}
	
	


}
