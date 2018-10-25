package SelCVO;

public class AcatinfoVO {

	private int aid;
	private String aname;
	private String aloc;
	private String achlog;
	private int ahits;
	private String acatname;
	private String ainfo;

	private String mem;

	private int clid;
	private String clname;
	private int clday;
	private String clstart;
	private String clend;
	private int ccost;
	private String clcatname;
	private String clinfo;

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

	public String getAchlog() {
		return achlog;
	}

	public void setAchlog(String achlog) {
		this.achlog = achlog;
	}

	public int getAhits() {
		return ahits;
	}

	public void setAhits(int ahits) {
		this.ahits = ahits;
	}

	public String getAcatname() {
		return acatname;
	}

	public void setAcatname(String acatname) {
		this.acatname = acatname;
	}

	public String getAinfo() {
		return ainfo;
	}

	public void setAinfo(String ainfo) {
		this.ainfo = ainfo;
	}

	public String getMem() {
		return mem;
	}

	public void setMem(String mem) {
		this.mem = mem;
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

	public String getClcatname() {
		return clcatname;
	}

	public void setClcatname(String clcatname) {
		this.clcatname = clcatname;
	}

	public String getClinfo() {
		return clinfo;
	}

	public void setClinfo(String clinfo) {
		this.clinfo = clinfo;
	}

	@Override
	public String toString() {
		return "AcatinfoVO [aid=" + aid + ", aname=" + aname + ", aloc=" + aloc + ", achlog=" + achlog + ", ahits="
				+ ahits + ", acatname=" + acatname + ", ainfo=" + ainfo + ", mem=" + mem + ", clid=" + clid
				+ ", clname=" + clname + ", clday=" + clday + ", clstart=" + clstart + ", clend=" + clend + ", ccost="
				+ ccost + ", clcatname=" + clcatname + ", clinfo=" + clinfo + "]";
	}

}
