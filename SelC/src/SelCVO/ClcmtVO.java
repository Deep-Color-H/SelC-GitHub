package SelCVO;

public class ClcmtVO {
	private String mnick;
	private int mid;
	private int clid;
	private int clcid;
	private String clcctx;
	private int clcscore;

	public String getMnick() {
		return mnick;
	}

	public void setMnick(String mnick) {
		this.mnick = mnick;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public int getClid() {
		return clid;
	}

	public void setClid(int clid) {
		this.clid = clid;
	}

	public int getClcid() {
		return clcid;
	}

	public void setClcid(int clcid) {
		this.clcid = clcid;
	}

	public String getClcctx() {
		return clcctx;
	}

	public void setClcctx(String clcctx) {
		this.clcctx = clcctx;
	}

	public int getClcscore() {
		return clcscore;
	}

	public void setClcscore(int clcscore) {
		this.clcscore = clcscore;
	}

	@Override
	public String toString() {
		return "ClcmtVO [mnick=" + mnick + ", mid=" + mid + ", clid=" + clid + ", clcid=" + clcid + ", clcctx=" + clcctx
				+ ", clcscore=" + clcscore + "]";
	}

}
