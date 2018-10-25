package SelCDB.Jdbc.BIZ;

import java.math.BigDecimal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import SelCDB.Jdbc.DAO.jdbcDao;
import SelCFunction.processImg;
import SelCVO.BoardVO;
import SelCVO.CmtVO;
import SelCVO.QABoardVO;

@Service
public class jdbcBiz {

	@Autowired
	@Qualifier("dao")
	jdbcDao dao;

	public Map<String, Object> BoardList(int page_num, String bcatid) {

		int startnum = (20 * page_num) - 19;
		int lastnum = (20 * page_num);

		Map res = dao.boardList_View(startnum, lastnum, bcatid);
		System.out.println(res.get("list_count"));
		int list_count = ((BigDecimal) res.get("list_count")).intValue();
		int page_count = 0;
		if (list_count == 0) {
			page_count = 1;
		} else
			page_count = (list_count + 19) / 20;

		res.put("list_count", list_count);
		res.put("page_count", page_count);

		return res;
	}

	public Map<String, Object> QABoardList(int page_num) {

		int startnum = 20 * page_num - 19;
		int lastnum = 20 * page_num;

		Map<String, Object> res = dao.QABoardList_View(startnum, lastnum);
		System.out.println(res.get("LIST_COUNT"));
		int list_count = ((BigDecimal) res.get("LIST_COUNT")).intValue();;
		int page_count = 0;
		if (list_count == 0) {
			page_count = 1;
		} else
			page_count = (list_count + 19) / 20;

		res.put("list_count", list_count);
		res.put("page_count", page_count);

		return res;
	}

	public Map<String, Object> BoardCnt(int bid) {
		Map res = dao.boardCnt_View(bid);
		return res;
	}

	public Map<String, Object> QABoardCnt(int bid) {
		Map res = dao.QaBoardCnt_view(bid);
		return res;
	}

	public int delete_post(int bid, int mid, String bcatid) {
		int res = 0;
		if (bcatid != null) {
			if (mid == dao.checkMid(bid)) {
				res = dao.delete_post(bid, bcatid);
			}
		} else if (bcatid == null) {
			if (mid == dao.checkQAMid(bid)) {
				res = dao.delete_post(bid, null);
			}
		}
		return res;
	}

	public int delete_coment(int cid) {
		int res = 0;
		res = dao.delete_coment(cid);
		return res;

	}

	public int delete_QAcoment(int cid, int bid) {
		int res =0;
		res = dao.delete_QAcoment(cid, bid);
		return 0;
	}
	
	
	
	
	public int delete_schedule(int sid, int mid) {
		int res = 0;
		if (mid == dao.checkSMId(mid)) {
			res = dao.delete_schedule(sid);
		}
		return res;
	}

	/*
	 * public ArrayList<ScheduleVO> Schdule_list(int mid) { Map res =
	 * dao.Schedule_list(mid); ArrayList<ScheduleVO> SList = new ArrayList(); SList
	 * = (ArrayList<ScheduleVO>) res; int i = 0 ArrayList<ScheduleVO> result = new
	 * ArrayList(); while(SList.get(i).getSpreid()==) {
	 * 
	 * } return res; }
	 */

	public int postToBoard(BoardVO boardVO, int mid) {
		
//		08-07 업데이트
		int result;
		
		if(boardVO.getBcatid().equals("BOARD_DIARY")) {
			
			if(boardVO.getBimg_org().isEmpty()) {
				result = dao.postToBoard2(boardVO, mid);
			}else {
				String bimg = dao.postToBoard(boardVO, mid);
				
				if(processImg.inputBoardImg(boardVO.getBimg_org(), bimg)) {
					result = 1;
				}else {
					result = 0;
				}
			}
			
		}else {
			result = dao.postToScheduleBoard(boardVO, mid);
		}
		return result;
		
	}

	public int postToQABoard(QABoardVO qaboardVO, int mid) {
		int res = 0;
		res = dao.postToQABoard(qaboardVO, mid);
		return res;
	}

	public int postToCMT(CmtVO cmtvo, int mid, int bid) {
		int res = 0;
		res = dao.postToCMT(cmtvo, mid, bid);
		return res;
	}

	public int postToQACMT(CmtVO cmtvo, int mid, int bid) {
		int res = 0;
		res = dao.postToQACMT(cmtvo, mid, bid);
		return res;
	}

	public int RevicePost(BoardVO boardVO, int bid) {
		int res = 0;

		if(!boardVO.getBimg_org().isEmpty()) {
			// 이미지가 있을 경우
			boardVO.setBimg(processImg.updateImg(boardVO.getBimg_org(), ""+bid));
		}else if(boardVO.getBimg() != null) {
			// 이미지가 없지만 이전에 등록한 이미지가 있는 경우
			boardVO.setBimg(boardVO.getBimg());
		}
		res = dao.RevicePost(boardVO, bid);
		return res;
	}
	
	public int ReviceQAPost(QABoardVO qaboardVO, int bid) {
		int res = 0;
		res = dao.ReviceQAPost(qaboardVO, bid);
		return res;
	}

	public int BoardRcm(int bid) {
		int res = 0;
		res = dao.BoardRcm(bid);
		return res;
	}

	public int CmtRcm(int cid) {
		int res = 0;
		res = dao.CmtRcm(cid);
		return res;
	}

	public int QACmtRcm(int cid) {
		int res = 0;
		res = dao.QACmtRcm(cid);
		return res;
	}
	
	public Map<String, Object> Boardsrch(int option, int page_num, String bcatid, String content) {
		int startnum = (20 * page_num) - 19;
		int lastnum = (20 * page_num);
		
		Map res = dao.boardsrch_View(startnum, lastnum, bcatid, option, content);
		System.out.println(res.get("list_count"));
		int list_count = ((BigDecimal) res.get("list_count")).intValue();
		int page_count = 0;
		if (list_count == 0) {
			page_count = 1;
		} else
			page_count = (list_count + 19) / 20;

		res.put("list_count", list_count);
		res.put("page_count", page_count);
		
		return res;
	}

	public Map<String, Object> QABoardsrch(int option, int page_num, String content) {
		int startnum = (20 * page_num) - 19;
		int lastnum = (20 * page_num);
		
		Map res = dao.QAboardsrch_View(startnum, lastnum, option, content);
		System.out.println(res.get("LIST_COUNT"));
		int list_count = ((BigDecimal) res.get("LIST_COUNT")).intValue();
		int page_count = 0;
		if (list_count == 0) {
			page_count = 1;
		} else
			page_count = (list_count + 19) / 20;

		res.put("list_count", list_count);
		res.put("page_count", page_count);
		
		return res;
		
		
	}
	



}
