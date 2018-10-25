package SelCController;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import SelCDB.Jdbc.BIZ.jdbcBiz;
import SelCVO.BoardVO;
import SelCVO.CmtVO;
import SelCVO.QABoardVO;

@Controller
public class BoardController {

	@Autowired
	jdbcBiz biz;
	
	@RequestMapping(value="/toBoardList_SCHEDULE.do", method=RequestMethod.GET)
	public ModelAndView list(@RequestParam("page_number") int page_number) {
		Map<String, Object> res = biz.BoardList(page_number, "BOARD_SCHEDULE");
		res.put("page_number", page_number);
		return new ModelAndView("Board/BoardList_SCHEDULE","res",res);
	}

	@RequestMapping(value="/toBoardList_DIARY.do", method=RequestMethod.GET)
	public ModelAndView diarylist(@RequestParam("page_number") int page_number) {
		Map<String, Object> res = biz.BoardList(page_number, "BOARD_DIARY");
		res.put("page_number", page_number);
		return new ModelAndView("Board/BoardList_DIARY","res",res);
	}
	@RequestMapping(value="/toBoardList_QA.do", method=RequestMethod.GET)
	public ModelAndView QAlist(@RequestParam("page_number") int page_number) {
		Map<String, Object> res = biz.QABoardList(page_number);
		res.put("page_number", page_number);
		return new ModelAndView("Board/BoardList_QA","res",res);
	}

	//게시판 내용조회
   @RequestMapping(value="/toBoard.do", method=RequestMethod.GET)
   public ModelAndView cnt(@RequestParam("bid") int bid) {
       Map<String, Object> res = biz.BoardCnt(bid);
       return new ModelAndView("Board/board","res",res);
   }
   //댓글쓰기
   @RequestMapping(value="/postToCMT.do", method=RequestMethod.GET)
   public ModelAndView postToCMT(@RequestParam("cctx") String cctx, HttpSession session, @RequestParam("bid") int bid) {
	   int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
	   CmtVO cmtvo = new CmtVO();
	   cmtvo.setCctx(cctx);
	   biz.postToCMT(cmtvo, mid, bid);
	   Map<String, Object> res = biz.BoardCnt(bid);
	   
	   return new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"res",res);
	   
   }    
   	//질문 게시판 내용조회
   @RequestMapping(value="/toQABoard.do", method=RequestMethod.GET)
   public ModelAndView qacnt(@RequestParam("bid") int bid) {
       Map<String, Object> res = biz.QABoardCnt(bid);
       return new ModelAndView("Board/board_QA","res",res);
   }
   
    //질문 게시판 댓글쓰기
    @RequestMapping(value="/postToQACMT.do", method=RequestMethod.GET)
    public ModelAndView postToQACMT(@ModelAttribute CmtVO cmtvo, HttpSession session, @RequestParam("bid") int bid) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        biz.postToQACMT(cmtvo, mid, bid);
        Map<String, Object> res = biz.QABoardCnt(bid);
        return new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"res",res);
    
    }
    
    //게시글삭제
    @RequestMapping("/delete_post_diary.do")
    public  ModelAndView delete_post(ModelAndView mav, @RequestParam("bid") int bid, HttpSession session, @RequestParam("bcatid") String bcatid) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = biz.delete_post(bid, mid, bcatid);
        if(res == 1) {
        	mav =  new ModelAndView("Board/board","message","게시글이삭제되었습니다.");
        	mav.setView(new RedirectView("toBoardList_DIARY.do?page_number=1"));
        }else if(res == 0) {
        	mav =  new ModelAndView("Board/board","message","'게시글'삭제에 실패하였습니다.");
        	mav.setView(new RedirectView("toBoard.do?bid="+bid));
        }
        return mav;
    }
    //질문 게시글삭제
    @RequestMapping("/delete_qapost_diary.do")
    public  ModelAndView delete_QApost(ModelAndView mav, @RequestParam("bid") int bid, HttpSession session) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = biz.delete_post(bid, mid, null);
        if(res == 1) {
        	mav =  new ModelAndView(new RedirectView("toBoardList_QA.do?page_number=1"),"message","질문이 삭제되었습니다.");
        }else if(res == 0) {
        	mav =  new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"message","질문 삭제에 실패하였습니다.");
        }
        return mav;
    }
    //댓글삭제
    @RequestMapping(value="/delete_cmt.do", method=RequestMethod.GET)
    public ModelAndView delete_Comment(ModelAndView mav, @RequestParam("bid") int bid, @RequestParam("cid") int cid, HttpSession session) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = biz.delete_coment(cid);
        if(res == 1) {
            Map<String, Object> result = biz.BoardCnt(bid);                
            mav =  new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"res",result);
        }else if(res == 0) {
        	mav =  new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"message","댓글 삭제에 실패했습니다.");
        }
        return mav;
    }
    //질문 게시판의 댓글삭제 //qa댓글 //qacmt
    @RequestMapping(value="/delete_qacmt.do", method=RequestMethod.GET)
    public ModelAndView delete_QAComment(ModelAndView mav, @RequestParam("bid") int bid, @RequestParam("cid") int cid, HttpSession session) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        int res = biz.delete_QAcoment(cid, bid);
        if(res == 1) {
            Map<String, Object> result = biz.QABoardCnt(bid);                
            mav =  new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"res",result);
        }else if(res == 0) {
        	mav =  new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"message","댓글 삭제에 실패했습니다.");
        }
        return mav;
    }
    
    
    //게시판 글쓰러가기
    @RequestMapping("gotoWrite_DIARY.do")
    public String writeBoard2() {
    	return "Board/BoardPost_DIARY";
    }
    @RequestMapping("gotoWrite_QA.do")
    public String writeBoard() {
    	return "Board/BoardPost_QA";
    }
    //게시판 글쓰기
    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public ModelAndView postToBoard(ModelAndView mav, @ModelAttribute BoardVO boardVO, HttpSession session) {
        int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
        //mid값 임의변경함 아래
        int res = biz.postToBoard(boardVO, mid);
        if(boardVO.getBcatid() == "BOARD_SCHEDULE")
        	if(res ==1) {
        		mav = new ModelAndView(new RedirectView("toBoardList_SCHEDULE.do?page_number=1"), "message", "'게시글이 등록되었습니다.'");
        	}else {
        		mav = new ModelAndView(new RedirectView("toBoardList_SCHEDULE.do?page_number=1"), "message", "'게시글 등록에 실패했습니다.'");
        	}
        else {
        	if(res ==1) {
        		mav = new ModelAndView(new RedirectView("toBoardList_DIARY.do?page_number=1"), "message", "'게시글이 등록되었습니다.'");
        	}else {
        		mav = new ModelAndView(new RedirectView("toBoardList_DIARY.do?page_number=1"), "message", "'게시글 등록에 실패했습니다.'");
        	}
        }
        
        
        return mav;
    }
    //질문 게시판 글쓰기 //글등록
    @RequestMapping(value="QAinsert.do", method=RequestMethod.POST)
    public ModelAndView postToQABoard(@ModelAttribute QABoardVO QAboardVO, HttpSession session) {
    	int mid = Integer.parseInt((String)session.getAttribute("Idcode"));
    	//mid값 임의변경함 아래
    	int res = biz.postToQABoard(QAboardVO, mid);
    	if(res ==1) {
    		return new ModelAndView(new RedirectView("toBoardList_QA.do?page_number=1"), "message", "'질문이 등록되었습니다.'");
    	}
    	
    	return new ModelAndView(new RedirectView("toBoardList_QA.do?page_number=1"), "message", "'질문 등록에 실패했습니다.'");
    }


    //게시판 수정하기 위한 내용 조회
    @RequestMapping(value="revice_postview.do")
    public ModelAndView revise_postveiw(@RequestParam("bid") int bid) {
        Map<String, Object> res = biz.BoardCnt(bid);
        return new ModelAndView("Board/boardCorrect","res",res);
    }
    
    //게시판 수정
    @RequestMapping(value="revice_post.do", method=RequestMethod.POST)
    public ModelAndView revice_post(ModelAndView mav, @ModelAttribute BoardVO boardVO, @RequestParam("bid") int bid, @RequestParam("bcatid") String bcatid) {
        int res = biz.RevicePost(boardVO, bid);
        if(res == 1) {
            Map<String, Object> result = biz.BoardCnt(bid);       
            mav =  new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"res",result);
        } else if(res == 0) {
        	mav =  new ModelAndView(new RedirectView("toBoard.do?bid="+bid),"message","수정에 실패하였습니다.");
        }
        return mav;
    }
    
    //QA질문게시판 수정하기 위한 내용 조회
    @RequestMapping(value="revice_QApostview.do")
    public ModelAndView revise_QApostveiw(@RequestParam("bid") int bid) {
        Map<String, Object> res = biz.QABoardCnt(bid);
        return new ModelAndView("Board/boardCorrect_QA","res",res);
    }
    
    //QA 질문게시판 수정 최종 내용수정위한 UPDATE
    @RequestMapping(value="revice_QApost.do", method=RequestMethod.GET)
    public ModelAndView revice_QApost(ModelAndView mav, @ModelAttribute QABoardVO QAboardVO, @RequestParam("bid") int bid, @RequestParam("bcatid") String bcatid) {
        int res = biz.ReviceQAPost(QAboardVO, bid);
        if(res == 1) {
            Map<String, Object> result = biz.BoardCnt(bid);       
            mav =  new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"res",result);
        }else if(res == 0) {
        	mav =  new ModelAndView(new RedirectView("toQABoard.do?bid="+bid),"message","수정에 실패하였습니다.");
        }
        return mav;
    }
    
    //게시판 및 댓글 추천
    @RequestMapping(value="rcm.do", method=RequestMethod.GET)
    public ModelAndView rcm(@RequestParam("bid") int bid, @RequestParam("cid") int cid) {
        if(cid==0) {
            biz.BoardRcm(bid);}
        else {
        	biz.CmtRcm(cid);
        }
        return new ModelAndView("redirect:toBoard.do?bid="+bid);
    }
    //질문게시판의 댓글 추천 (질문 게시판은 댓글만 있음
    @RequestMapping(value="qarcm.do", method=RequestMethod.GET)
    public ModelAndView qarcm(@RequestParam("bid") int bid, @RequestParam("cid") int cid) {
        biz.QACmtRcm(cid);
        return new ModelAndView(new RedirectView("toQABoard.do?bid="+bid));
    }
	
    // 다이어리 게시판 조건검색
	@RequestMapping(value="/goDiarySrch.do", method=RequestMethod.GET)
	public ModelAndView DiarySrch(@RequestParam("page_number") int page_number, @RequestParam("content") String content, @RequestParam("option") String option) {
		int option_int = Integer.parseInt(option);
		Map<String, Object> res = biz.Boardsrch(option_int, page_number, "BOARD_DIARY", content);
		res.put("page_number", page_number);
		return new ModelAndView("Board/BoardList_DIARY","res",res);
	}
    
	// QA 게시판 조건검색
	@RequestMapping(value="/goQASrch.do", method=RequestMethod.GET)
	public ModelAndView QASrch(@RequestParam("page_number") int page_number, @RequestParam("content") String content, @RequestParam("option") String option) {
		int option_int = Integer.parseInt(option);
		Map<String, Object> res = biz.QABoardsrch(option_int, page_number, content);
		res.put("page_number", page_number);
		return new ModelAndView("Board/BoardList_QA","res",res);
	}
}
