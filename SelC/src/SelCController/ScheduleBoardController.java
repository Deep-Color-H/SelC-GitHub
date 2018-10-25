package SelCController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import SelCDB.Jdbc.BIZ.jdbcBiz;
import SelCDB.spring.BIZ.SpringBiz;
import SelCVO.BoardVO;
import SelCVO.CmtVO;
import SelCVO.ScheduleVO;

@Controller
public class ScheduleBoardController {

	@Autowired
	SpringBiz biz;
	
	@Autowired
	jdbcBiz jbiz;
	
	@RequestMapping("/gotoWrite_SCHEDULE.do")
    public ModelAndView writeSchedule_Board(HttpSession session) {
		int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
		Map ScheduleMap = biz.getScheduleList(mid);
    	return new ModelAndView("Board/BoardPost_SCHEDULE","ScheduleMap",ScheduleMap);
    }
	
	@RequestMapping("/make_SCHEDULE.do")
	public ModelAndView returnScheduletoPost(@RequestParam("stitle") String stitle, HttpSession session) {
		HashMap<String, Object> map = (HashMap<String, Object>)session.getAttribute("ScheduleList");
		return new ModelAndView("Board/Schedule/schedule_view","Schedule",map.get(stitle));
	}
	
	@RequestMapping("/postBoard_Schedule.do")
	public String postScheduletoBoard(@RequestParam("schedule") String schedule, @ModelAttribute BoardVO boardVO, HttpSession session) {
		int sid = biz.getScheduleId(schedule);
		int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
		boardVO.setSid(sid);
		boardVO.setMid(mid);
		jbiz.postToBoard(boardVO, mid);
		return "redirect: toBoardList_SCHEDULE.do?page_number=1";
	}
	
	@RequestMapping("/view_SCHEDULE.do")
	public ModelAndView viewSchedule(HttpSession session) {
		ArrayList<ScheduleVO> schedule = (ArrayList<ScheduleVO>)session.getAttribute("schedule");
		return new ModelAndView("Board/Schedule/schedule_view","Schedule",schedule);
	}
	
	@RequestMapping(value="/toScheduleBoard.do", method=RequestMethod.GET)
	public ModelAndView letmeseeyourSchdule(@RequestParam int bid, HttpSession session) {

		
		Map<String, Object> res = jbiz.BoardCnt(bid);
	    int sid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getSid();
	    ArrayList<ScheduleVO> schedule = biz.getSchedule(sid); 
	    res.put("schedule", schedule);
	    session.setAttribute("schedule",schedule);
	    
//	    08-06 업데이트
	    int mid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getMid();
	    
	    String path  = biz.getImagePath(mid);
	    res.put("path", path);
	    
	    return new ModelAndView("Board/Schedule/schedule_board_new","res",res);
	}
	
	//8월 7일 ----------------------------------------------------------
    //게시판 및 댓글 추천
    @RequestMapping(value="rcm_sc.do", method=RequestMethod.GET)
    public ModelAndView rcm(@RequestParam("bid") int bid, @RequestParam("cid") int cid, HttpSession session) {
        if(cid==0) {
            jbiz.BoardRcm(bid);}
        else {
        	jbiz.CmtRcm(cid);
        }
		Map<String, Object> res = jbiz.BoardCnt(bid);
	    int sid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getSid();
	    
	    ArrayList<ScheduleVO> schedule = biz.getSchedule(sid); 
	    res.put("schedule", schedule);
	    session.setAttribute("schedule",schedule);
	    
	    int mid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getMid();
	    
	    String path  = biz.getImagePath(mid);
	    res.put("path", path);
	    
	    return new ModelAndView("Board/Schedule/schedule_board_new","res",res);
    }
    //댓글등록
    @RequestMapping(value="/postTo_SC_CMT.do", method=RequestMethod.GET)
    public ModelAndView postToCMT(@RequestParam("cctx") String cctx, HttpSession session, @RequestParam("bid") int bid) {
 	   int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
 	   CmtVO cmtvo = new CmtVO();
 	   cmtvo.setCctx(cctx);
 	   jbiz.postToCMT(cmtvo, mid, bid);
       Map<String, Object> res = jbiz.BoardCnt(bid);
	   int sid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getSid();
	   ArrayList<ScheduleVO> schedule = biz.getSchedule(sid); 
	   res.put("schedule", schedule);
	   session.setAttribute("schedule",schedule);
	    
	   mid = (((ArrayList<BoardVO>)res.get("board_cur")).get(0)).getMid();
	    
	   String path  = biz.getImagePath(mid);
	   res.put("path", path);
 	   
 	   return new ModelAndView(new RedirectView("toScheduleBoard.do?bid="+bid),"res",res);
    } 
    
    
     //댓글삭제 
    @RequestMapping(value="/delete_SC_cmt.do", method=RequestMethod.GET)
    public ModelAndView delete_Comment(@RequestParam("bid") int bid, @RequestParam("cid") int cid, HttpSession session) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = jbiz.delete_coment(cid);
        
   	  	Map<String, Object> result = jbiz.BoardCnt(bid);
	    int sid = (((ArrayList<BoardVO>)result.get("board_cur")).get(0)).getSid();
	    ArrayList<ScheduleVO> schedule = biz.getSchedule(sid); 
	    result.put("schedule", schedule);
	    session.setAttribute("schedule",schedule);
	    
	    mid = (((ArrayList<BoardVO>)result.get("board_cur")).get(0)).getMid();
	    
	    String path  = biz.getImagePath(mid);
	    result.put("path", path);
	   
        if(res == 1) {              
            return new ModelAndView(new RedirectView("toScheduleBoard.do?bid="+bid),"res",result);
        }
        return new ModelAndView(new RedirectView("toScheduleBoard.do?bid="+bid),"message","댓글삭제에 실패하였습니다.");
    }
    
    //게시글삭제
    @RequestMapping("/delete_SC_post_diary.do")
    public  ModelAndView delete_post(@RequestParam("bid") int bid, HttpSession session, @RequestParam("bcatid") String bcatid) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = jbiz.delete_post(bid, mid, bcatid);
        if(res == 1) {
            return new ModelAndView(new RedirectView("toBoardList_SCHEDULE.do?page_number=1"),"message","게시글이삭제되었습니다.");
        }
        return new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"message","'게시글'삭제에 실패하였습니다.");
    }
    
    //게시판 수정하기 위한 내용 조회
    @RequestMapping(value="revice_SC_postview.do")
    public ModelAndView revise_postveiw(@RequestParam("bid") int bid) {
        Map<String, Object> res = jbiz.BoardCnt(bid);
        return new ModelAndView("Board/Schedule/boardCorrect_SCHEDULE","res",res);
    }
    
    //게시판 수정
    @RequestMapping(value="revice_SC_post.do", method=RequestMethod.GET)
    public ModelAndView revice_post(@ModelAttribute BoardVO boardVO, @RequestParam("bid") int bid, 
    								@RequestParam("bcatid") String bcatid, HttpSession session) {
    	
        int res = jbiz.RevicePost(boardVO, bid);
        Map<String, Object> result = jbiz.BoardCnt(bid);  
        int sid = (((ArrayList<BoardVO>)result.get("board_cur")).get(0)).getSid();
        ArrayList<ScheduleVO> schedule = biz.getSchedule(sid);
        result.put("schedule", schedule);
        session.setAttribute("schedule",schedule);
        int mid = (((ArrayList<BoardVO>)result.get("board_cur")).get(0)).getMid();
	    
	    String path  = biz.getImagePath(mid);
	    result.put("path", path);
        if(res == 1) {
            return  new ModelAndView(new RedirectView("toScheduleBoard.do?bid="+bid),"res",result);
        }
        return new ModelAndView(new RedirectView("toScheduleBoard.do?bid="+bid),"res",result);
    }
    
    
  //스케줄 공유게시판 조건 검색
    @RequestMapping(value="/goScheduleSrch.do", method=RequestMethod.GET)
    public ModelAndView DiarySrch(@RequestParam("page_number") int page_number, @RequestParam("content") String content, @RequestParam("option") String option) {
        int option_int = Integer.parseInt(option);
        Map<String, Object> res = jbiz.Boardsrch(option_int, page_number, "BOARD_SCHEDULE", content);
        res.put("page_number", page_number);
        return new ModelAndView("Board/BoardList_SCHEDULE","res",res);
    }
    
}
