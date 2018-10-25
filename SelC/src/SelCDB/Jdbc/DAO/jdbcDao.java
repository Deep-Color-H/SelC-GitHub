package SelCDB.Jdbc.DAO;

import java.awt.print.PrinterException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.print.PrintException;

import org.apache.ibatis.jdbc.SQL;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import SelCVO.BoardVO;
import SelCVO.CmtVO;
import SelCVO.QABoardVO;
import SelCVO.ScheduleVO;
import oracle.jdbc.OracleTypes;
import oracle.jdbc.oracore.OracleType;

@Repository
public class jdbcDao extends JdbcDaoSupport implements jdbcDaoSql{
	
	jdbcDaoPrcd daoPrcd; 
	
	public Map boardList_View(int startNum, int lastNum, String bcatid) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(7);
		daoPrcd.setBcatId(bcatid);
		daoPrcd.setStartNum(startNum);
		daoPrcd.setLastNum(lastNum);
		daoPrcd.setSql(board_listview);
		ArrayList<Object> result = new ArrayList<>();
		result.add(new SqlParameter("startnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("lastnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("p_bcatid", OracleTypes.CHAR));
		result.add(new SqlOutParameter("rs_list_cur", OracleTypes.CURSOR,new RowMapper<BoardVO>() {

			@Override  //while안해도 되는건가???
			public BoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
					BoardVO res = new BoardVO();	
					res.setBid(rs.getInt("BID"));
					res.setBtitle(rs.getString("BTITLE"));
					res.setBrcm(rs.getInt("BRCM"));
					res.setBhits(rs.getInt("BHITS"));
					res.setBtime(rs.getDate("BTIME"));
					res.setMid(rs.getInt("MID"));
					res.setMnick(rs.getString("MNICK"));
					res.setBgrname(rs.getString("BGRNAME"));
					return res;
			}
			
		}));
		result.add(new SqlOutParameter("list_count", OracleTypes.INTEGER));
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		System.out.println(res);
		return res;	
	}
	
	public Map QABoardList_View(int startnum, int lastnum) {
	        
	        daoPrcd = new jdbcDaoPrcd();
	        daoPrcd.setSelectnum(8);
	        daoPrcd.setStartNum(startnum);
	        daoPrcd.setLastNum(lastnum);
	        daoPrcd.setSql(board_qalistview);
	        
	        ArrayList<Object> result = new ArrayList<>();
	        
	        // 화면 상 보여줄 첫 리스트 번호
	        result.add(new SqlParameter("STARTNUM", OracleTypes.INTEGER));
	        // 화면 상 보여줄 마지막 리스트 번호    
	        result.add(new SqlParameter("LASTNUM", OracleTypes.INTEGER));
	        
	        result.add(new SqlOutParameter("RS_LIST_CUR", OracleTypes.CURSOR, new RowMapper<QABoardVO>() {

	            @Override
	            public QABoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
	         
	                    QABoardVO res = new QABoardVO();
	                    res.setBid(rs.getInt("BID"));
	                    res.setBtitle(rs.getString("BTITLE"));
	                    res.setBhits(rs.getInt("BHITS"));
	                    res.setBtime(rs.getDate("BTIME"));
	                    res.setMnick(rs.getString("MNICK"));
	                    res.setMid(rs.getInt("MID"));
	                    res.setBach(rs.getString("BACH"));
	                    return res;
	            }
	        }));
	        result.add(new SqlOutParameter("LIST_COUNT", OracleTypes.INTEGER));
	        Map res = getJdbcTemplate().call(daoPrcd, (List)result);
	        System.out.println(res);
	        return res;
	    }
	
	public Map boardCnt_View(int bid) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(5);
		daoPrcd.setBid(bid);
		daoPrcd.setSql(board_view);
		ArrayList<Object> result = new ArrayList<>();
		
		result.add(new SqlParameter("bid",OracleTypes.INTEGER));
		result.add(new SqlOutParameter("board_cur",OracleTypes.CURSOR,new RowMapper<BoardVO>() {

			@Override
			public BoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
					BoardVO res = new BoardVO();
					res.setMnick(rs.getString("MNICK"));
					res.setBid(rs.getInt("BID"));
					res.setBcatid(rs.getString("BCATID"));
					res.setMid(rs.getInt("MID"));
					res.setSid(rs.getInt("SID"));
					res.setBtitle(rs.getString("BTITLE"));
					res.setBctx(rs.getString("BCTX"));
					res.setBtime(rs.getDate("BTIME"));
					res.setBrcm(rs.getInt("BRCM"));
					res.setBhits(rs.getInt("BHITS"));
					res.setBimg(rs.getString("BIMG"));
				return res;
			}
		}));
		
		result.add(new SqlOutParameter("cmt_cur",OracleTypes.CURSOR,new RowMapper<CmtVO>() {

			@Override
			public CmtVO mapRow(ResultSet rs, int rownum) throws SQLException {
					CmtVO res = new CmtVO();
					res.setCmnick(rs.getString("CMNICK"));
					res.setCmid(rs.getInt("CMID"));
					res.setCbid(rs.getInt("CBID"));
					res.setCctx(rs.getString("CCTX"));
					res.setCtime(rs.getDate("CTIME"));
					res.setCrcm(rs.getInt("CRCM"));
					res.setCid(rs.getInt("Cid"));
					result.add(res);
				return res;
			}
		}));
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		System.out.println(res);
		return res;
	}

	public Map QaBoardCnt_view(int bid) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(6);
		daoPrcd.setBid(bid);
		daoPrcd.setSql(qaboard_view);
		ArrayList<Object> result = new ArrayList<>();
		
		result.add(new SqlParameter("bid", OracleTypes.INTEGER));
		result.add(new SqlOutParameter("qa_board_cur", OracleTypes.CURSOR, new RowMapper<QABoardVO>() {
			@Override
			public QABoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
					QABoardVO res = new QABoardVO();
					res.setMnick(rs.getString("MNICK"));
					res.setMid(rs.getInt("MID"));
					res.setBid(rs.getInt("BID"));
					res.setBtitle(rs.getString("BTITLE"));
					res.setBctx(rs.getString("BCTX"));
					res.setBtime(rs.getDate("BTIME"));
					res.setBhits(rs.getInt("BHITS"));
					res.setBach(rs.getString("BACH"));
					
				return res;
			}
		}));
		result.add(new SqlOutParameter("qa_cmt_cur", OracleTypes.CURSOR, new RowMapper<CmtVO>() {

			@Override
			public CmtVO mapRow(ResultSet rs, int rownum) throws SQLException {
				CmtVO res = new CmtVO();
				res.setCmnick(rs.getString("MNICK"));
				res.setCmid(rs.getInt("MID"));
				res.setCbid(rs.getInt("QABID"));
				res.setCctx(rs.getString("CCTX"));
				res.setCtime(rs.getDate("CTIME"));
				res.setCrcm(rs.getInt("CRCM"));
				res.setCid(rs.getInt("CID"));
			return res;
			}
			 
		}));
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		System.out.println(res);
		return res;	
	}

	
	/// MID값 확인후 게시글 삭제하는 쿼리문 ////---------------------------------------------------
	public int checkMid(int bid) {
		int res = Integer.parseInt(getJdbcTemplate().queryForObject
				(getmidbybid, new Object[] {bid}, String.class));
		return res;
	}
	public int checkQAMid(int bid) {
		int res = Integer.parseInt(getJdbcTemplate().queryForObject
				(getmidbybid_2, new Object[] {bid}, String.class));
		return res;
	}
	
	public int delete_post(int bid, String bcatid) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(10);
		daoPrcd.setBid(bid);
		daoPrcd.setBcatId(bcatid);
		daoPrcd.setSql(delete_post);
		ArrayList<Object> result = new ArrayList<>();
		result.add(new SqlParameter("bid", OracleTypes.INTEGER));
		result.add(new SqlParameter("bcatid", OracleTypes.VARCHAR));
		try {
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	//////////////////////////////////////////////////////////////////////////////////
	
	//MID값 확인 후 댓글 삭제하는 쿼리문 /////////////////////////////////////////////////////////

	public int delete_coment(int cid) {
		int res = getJdbcTemplate().update(deletecmtbycid, cid);
		return res;
	}


	   public int delete_QAcoment(int cid, int bid) {
		      daoPrcd = new jdbcDaoPrcd();
		      daoPrcd.setCid(cid);
		      daoPrcd.setBid(bid);
		      daoPrcd.setSelectnum(19);
		      daoPrcd.setSql(delete_qa_cmt);
		      ArrayList<Object> result = new ArrayList<>();
		      result.add(new SqlParameter("cid", OracleTypes.INTEGER));
		      result.add(new SqlParameter("bid", OracleTypes.INTEGER));
		      Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		      return 1;
		   }   
	
	
	///MID확인후 스케줄 삭제하는 쿼리문 //////////////////////////////////////////////////////////////
	public int checkSMId(int bid) {
		int res = Integer.parseInt(getJdbcTemplate().queryForObject
				(getmidbybid_3,new Object[] {bid}, String.class));
		return res;
	}
	
	

	public int delete_schedule(int sid) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSid(sid);
		daoPrcd.setSelectnum(11);
		daoPrcd.setSql(delete_schedule);
		ArrayList<Object> result = new ArrayList<>();
		result.add(new SqlParameter("sid", OracleTypes.INTEGER));
		try {
			Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		}catch (Exception e) {
			return 0;
		}
		return 1;
	}
/*
	public Map Schedule_list(int mid) {
		ArrayList<Map<String, Object>> res;
		res = (ArrayList<Map<String, Object>>) getJdbcTemplate().queryForList //자신이 등록한 스케줄 리스트목록(클래스명과 학원명을 포함함)
				("SELECT  S.SID, C.CLID, S.MID, S.SPREID, C.CLNAME, C.CLDAY, C.CLSTART, C.CLEND, C.CCOST, C.AID, C.CLCATID, A.ALOC, A.ACATID, A.ANAME"
						+ " FROM SCHEDULE S, ACADEMY A, CLASS C \r\n" + 
						"JOIN ACADEMY ON  C.AID=ACADEMY.AID \r\n" + 
						"JOIN SCHEDULE ON C.CLID=SCHEDULE.CLID\r\n" + 
						"WHERE MID = ?",mid, new RowMapper<ScheduleVO>() {

					@Override
					public ScheduleVO mapRow(ResultSet rs, int rownum) throws SQLException {
						ScheduleVO res = new ScheduleVO();
						res.setSid(rs.getInt("SID"));				res.setMid(rs.getInt("MID"));
						res.setClid(rs.getString("CLID"));			res.setClstart(rs.getDate("CLSTART"));
						res.setSpreid(rs.getInt("SPREID"));			res.setClend(rs.getDate("CLEND"));
						res.setAid(rs.getInt("AID"));				res.setClday(rs.getInt("CLDAY"));
						res.setClname(rs.getString("CLNAME"));		res.setCcost(rs.getInt("CCOST"));
						res.setAname(rs.getString("ANAME"));		res.setCLCATID(rs.getString("CLCATID"));
						res.setAloc(rs.getString("ALOC"));	 		res.setAcatid(rs.getString("ACATID"));
						return res;
					}
				});
			Map result = (Map) res;
		return result;
	}
*/
public String postToBoard(BoardVO boardVO, int mid) {
		
		daoPrcd = new jdbcDaoPrcd();

		daoPrcd.setSelectnum(18);
		daoPrcd.setBcatId(boardVO.getBcatid());
		daoPrcd.setMid(mid);
		daoPrcd.setBtittle(boardVO.getBtitle());
		daoPrcd.setBctx(boardVO.getBctx());
		daoPrcd.setSql(inert_board);
		
		ArrayList<Object> result = new ArrayList<>();
		
		result.add(new SqlParameter("bcatid", OracleTypes.VARCHAR));
		result.add(new SqlParameter("mid", OracleTypes.INTEGER));
		result.add(new SqlParameter("btitle", OracleTypes.VARCHAR));
		result.add(new SqlParameter("bctx", OracleTypes.VARCHAR));
		result.add(new SqlOutParameter("bid", OracleTypes.INTEGER));
		
		
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
        int bid = (int)res.get("bid");
        String bimg = bid+"1.png";
        int rs = getJdbcTemplate().update("UPDATE BOARD SET BIMG='"+bimg+"' WHERE BID="+bid);
        
        return bimg;
	}
	   public int postToBoard2(BoardVO boardVO, int mid) {
		      int res =0;
		      System.out.println(boardVO.getBcatid());
		      System.out.println(boardVO);
		      
		         res = getJdbcTemplate().update(insert_board,
		                boardVO.getBcatid(), mid,
		                boardVO.getBtitle(), boardVO.getBctx(), boardVO.getBimg()
		               );
		      
		      return res;
	   }
	public int postToScheduleBoard(BoardVO boardVO, int mid) {
		int res =0;
			res = getJdbcTemplate().update(insert_scheduleboard,
				 boardVO.getBcatid(), mid, boardVO.getSid(),
				 boardVO.getBtitle(), boardVO.getBctx(), boardVO.getBimg()
				);
			return res;
	}

	public int postToQABoard(QABoardVO qaboardVO, int mid) {
		int res = getJdbcTemplate().update(insert_qaboard,
				mid, qaboardVO.getBtitle(), qaboardVO.getBctx()
				);
		return res;
	}

	public int postToCMT(CmtVO cmtvo, int mid, int bid) {
		int res = getJdbcTemplate().update(insert_cmt,
				mid, bid, cmtvo.getCctx());
		return res;
	}
	public int postToQACMT(CmtVO cmtvo, int mid, int bid) {
		int res = getJdbcTemplate().update(insert_cmt_2,
				mid, bid, cmtvo.getCctx());
		return res;
	}

	public int RevicePost(BoardVO boardVO, int bid) {
		int res = getJdbcTemplate().update(update_board,
				boardVO.getBtitle(), boardVO.getBctx(), boardVO.getBimg(), bid);
		return res;
	}
	public int ReviceQAPost(QABoardVO qaboardVO, int bid) {
		int res = getJdbcTemplate().update(update_board_2,
				qaboardVO.getBtitle(), qaboardVO.getBctx(), qaboardVO.getBid());
		return res;
	}

	//댓글 추천
	public int BoardRcm(int bid) {
		int res = getJdbcTemplate().update(recommend_board, bid);
		return res;
	}

	public int CmtRcm(int cid) {
		int res = getJdbcTemplate().update(recommend_cmt, cid);
		return res;
	}

	public int QACmtRcm(int cid) {
		int res = getJdbcTemplate().update(recommend_cmt, cid);
		return 0;
	}
	//검색 조회
	public Map boardsrch_View(int startnum, int lastnum, String bcatid, int option, String content) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(15);
		daoPrcd.setStartNum(startnum);
		daoPrcd.setLastNum(lastnum);
		daoPrcd.setBcatId(bcatid);
		daoPrcd.setContent(content);
		daoPrcd.setOption(option);
		daoPrcd.setSql(board_srch);
		ArrayList<Object> result = new ArrayList<>();
		result.add(new SqlParameter("startnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("lastnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("p_bcatid", OracleTypes.CHAR));
		result.add(new SqlParameter("p_option", OracleTypes.NUMBER));
		result.add(new SqlParameter("p_content", OracleTypes.CHAR));		
		result.add(new SqlOutParameter("rs_list_cur", OracleTypes.CURSOR,new RowMapper<BoardVO>() {

			@Override  //while안해도 되는건가???
			public BoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
					BoardVO res = new BoardVO();	
					res.setBid(rs.getInt("BID"));
					res.setBtitle(rs.getString("BTITLE"));
					res.setBrcm(rs.getInt("BRCM"));
					res.setBhits(rs.getInt("BHITS"));
					res.setBtime(rs.getDate("BTIME"));
					res.setMid(rs.getInt("MID"));
					res.setMnick(rs.getString("MNICK"));
					res.setBgrname(rs.getString("BGRNAME"));
					return res;
			}
			
		}));
		result.add(new SqlOutParameter("list_count", OracleTypes.NUMBER));
		Map res = getJdbcTemplate().call(daoPrcd, (List)result);
		return res;	
	}


	public Map QAboardsrch_View(int startnum, int lastnum, int option, String content) {
		daoPrcd = new jdbcDaoPrcd();
		daoPrcd.setSelectnum(17);
		daoPrcd.setStartNum(startnum);
		daoPrcd.setLastNum(lastnum);
		daoPrcd.setContent(content);
		daoPrcd.setOption(option);
		daoPrcd.setSql(qaboard_srch);
		ArrayList<Object> result = new ArrayList<>();
		result.add(new SqlParameter("startnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("lastnum",OracleTypes.NUMBER));
		result.add(new SqlParameter("p_option", OracleTypes.NUMBER));
		result.add(new SqlParameter("p_content", OracleTypes.CHAR));		

	        result.add(new SqlOutParameter("RS_LIST_CUR", OracleTypes.CURSOR, new RowMapper<QABoardVO>() {

	            @Override
	            public QABoardVO mapRow(ResultSet rs, int rownum) throws SQLException {
	         
	                    QABoardVO res = new QABoardVO();
	                    res.setBid(rs.getInt("BID"));
	                    res.setBtitle(rs.getString("BTITLE"));
	                    res.setBhits(rs.getInt("BHITS"));
	                    res.setBtime(rs.getDate("BTIME"));
	                    res.setMnick(rs.getString("MNICK"));
	                    res.setBgrname(rs.getString("BGRNAME"));
	                    res.setMid(rs.getInt("MID"));
	                    res.setBach(rs.getString("BACH"));
	                    return res;
	            }
	        }));
        result.add(new SqlOutParameter("LIST_COUNT", OracleTypes.INTEGER));
        Map res = getJdbcTemplate().call(daoPrcd, (List)result);
        return res;
    }

	

}
