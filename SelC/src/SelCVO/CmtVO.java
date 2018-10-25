package SelCVO;

import java.util.Date;

public class CmtVO {
	@Override
	public String toString() {
		return "CmtVO [cmnick=" + cmnick + ", cmid=" + cmid + ", qabid=" + qabid + ", cbid=" + cbid + ", cctx=" + cctx
				+ ", ctime=" + ctime + ", crcm=" + crcm + cid+"]";
	}

	private String cmnick;
	private int cmid;
	private String qabid;
	private int cbid;
	private String cctx;
	private Date ctime;
	private int crcm;
	private int cid;

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getCrcm() {
		return crcm;
	}

	public void setCrcm(int crcm) {
		this.crcm = crcm;
	}

	

	public String getQabid() {
		return qabid;
	}

	public void setQabid(String qabid) {
		this.qabid = qabid;
	}


	public String getCmnick() {
		return cmnick;
	}

	public void setCmnick(String cmnick) {
		this.cmnick = cmnick;
	}

	public int getCmid() {
		return cmid;
	}

	public void setCmid(int cmid) {
		this.cmid = cmid;
	}

	public int getCbid() {
		return cbid;
	}

	public void setCbid(int cbid) {
		this.cbid = cbid;
	}

	public String getCctx() {
		return cctx;
	}

	public void setCctx(String cctx) {
		this.cctx = cctx;
	}

	public Date getCtime() {
		return ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}



}
