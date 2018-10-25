package SelCDB.Jdbc.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.jdbc.core.CallableStatementCreator;

import oracle.jdbc.OracleTypes;
import oracle.jdbc.oracore.OracleType;

public class jdbcDaoPrcd implements CallableStatementCreator {
	
	private int selectnum;
	private int bid;
	private String sql;
	private int startNum;
	private int lastNum;
	private String bcatId;
	private int count;
	private int sid;
	private int option;
	private String content;
	private int cid;
	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	private int mid;
	private String btittle;
	private String bctx;
	
	

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getBtittle() {
		return btittle;
	}

	public void setBtittle(String btittle) {
		this.btittle = btittle;
	}

	public String getBctx() {
		return bctx;
	}

	public void setBctx(String bctx) {
		this.bctx = bctx;
	}

	public int getOption() {
		return option;
	}

	public void setOption(int option) {
		this.option = option;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getLastNum() {
		return lastNum;
	}

	public void setLastNum(int lastNum) {
		this.lastNum = lastNum;
	}

	public String getBcatId() {
		return bcatId;
	}

	public void setBcatId(String catId) {
		this.bcatId = catId;
	}

	public int getSelectnum() {
		return selectnum;
	}

	public void setSelectnum(int selectnum) {
		this.selectnum = selectnum;
	}
	
	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	@Override
	public CallableStatement createCallableStatement(Connection conn) throws SQLException {
		CallableStatement callstmt = conn.prepareCall(sql);
		switch (selectnum) {
		case 1:
			
			break;
		case 2:
			
			break;
		case 3:
			
			break;
		case 4:
			
			break;
		case 5:
			callstmt.setInt(1, this.getBid());
			callstmt.registerOutParameter(2, OracleTypes.CURSOR);
			callstmt.registerOutParameter(3, OracleTypes.CURSOR);
			break;
		case 6:
			callstmt.setInt(1, this.getBid());
			callstmt.registerOutParameter(2, OracleTypes.CURSOR);
			callstmt.registerOutParameter(3, OracleTypes.CURSOR);
			break;
		case 7:
			callstmt.setInt(1, this.getStartNum());
			callstmt.setInt(2, this.getLastNum());
			callstmt.setString(3, this.getBcatId());
			callstmt.registerOutParameter(4, OracleTypes.CURSOR);
			callstmt.registerOutParameter(5, OracleTypes.NUMBER);
			return callstmt;
		case 8:
			 callstmt.setInt(1, this.getStartNum());
			 callstmt.setInt(2, this.getLastNum());
			 callstmt.registerOutParameter(3, OracleTypes.CURSOR);
			 callstmt.registerOutParameter(4, OracleTypes.NUMBER);   
			 return callstmt;
		case 10:
			callstmt.setInt(1, this.getBid());
			callstmt.setString(2, this.getBcatId());
			return callstmt;
		case 11:
			callstmt.setInt(1, this.getSid());
			return callstmt;
		case 15:
			 callstmt.setInt(1, this.getStartNum());
			 callstmt.setInt(2, this.getLastNum());
			 callstmt.setString(3, this.getBcatId());
			 callstmt.setInt(4, this.getOption());
			 callstmt.setString(5, this.getContent());
			 callstmt.registerOutParameter(6, OracleTypes.CURSOR);
			 callstmt.registerOutParameter(7, OracleTypes.NUMBER);  
			 return callstmt;
		case 17:
			 callstmt.setInt(1, this.getStartNum());
			 callstmt.setInt(2, this.getLastNum());
			 callstmt.setInt(3, this.getOption());		
			 callstmt.setString(4, this.getContent());
			 callstmt.registerOutParameter(5, OracleTypes.CURSOR);
			 callstmt.registerOutParameter(6, OracleTypes.NUMBER);
			 return callstmt;
		case 18:
			callstmt.setString(1, this.getBcatId());
			callstmt.setInt(2, this.getMid());
			callstmt.setString(3, this.getBtittle());
			callstmt.setString(4, this.getBctx());
			callstmt.registerOutParameter(5, OracleTypes.INTEGER);
			return callstmt;
	      case 19:
	          callstmt.setInt(1, this.getCid());
	          callstmt.setInt(2, this.getBid());
	          return callstmt;
		}
		return callstmt;
		
	}

}
