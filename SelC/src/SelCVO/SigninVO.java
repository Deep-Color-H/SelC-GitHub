package SelCVO;

import org.springframework.web.multipart.MultipartFile;

public class SigninVO {

	private String mid;
	private MultipartFile mpfimg_org;
	private String mpfimg;
	private String mem;
	private String mpw;
	private String mname;
	private String mnick;
	private String mage;
	private String maddr;
	private String mchemail;

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public MultipartFile getMpfimg_org() {
		return mpfimg_org;
	}

	public void setMpfimg_org(MultipartFile mpfimg_org) {
		this.mpfimg_org = mpfimg_org;
	}

	public String getMchemail() {
		return mchemail;
	}

	public void setMchemail(String mchemail) {
		this.mchemail = mchemail;
	}

	public String getMpfimg() {
		return mpfimg;
	}

	public void setMpfimg(String mpfimg) {
		this.mpfimg = mpfimg;
	}

	public String getMem() {
		return mem;
	}

	public void setMem(String mem) {
		this.mem = mem;
	}

	public String getMpw() {
		return mpw;
	}

	public void setMpw(String mpw) {
		this.mpw = mpw;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMnick() {
		return mnick;
	}

	public void setMnick(String mnick) {
		this.mnick = mnick;
	}

	public String getMage() {
		return mage;
	}

	public void setMage(String mage) {
		this.mage = mage;
	}

	public String getMaddr() {
		return maddr;
	}

	public void setMaddr(String maddr) {
		this.maddr = maddr;
	}

	@Override
	public String toString() {
		return "SigninVO [mpfimg_org=" + mpfimg_org + ", mpfimg=" + mpfimg + ", mem=" + mem + ", mpw=" + mpw
				+ ", mname=" + mname + ", mnick=" + mnick + ", mage=" + mage + ", maddr=" + maddr + ", mchemail="
				+ mchemail + "]";
	}

}
