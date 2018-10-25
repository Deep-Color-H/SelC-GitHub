package SelCController;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import SelCDB.spring.BIZ.SpringBiz;
import SelCFunction.compareStringTime;
import SelCVO.AcatinfoVO;
import SelCVO.ClcmtVO;
import SelCVO.ScheduleVO;
import SelCVO.SrchClVO;
import SelCVO.srchOptionVO;
import SelCVO.srchResultVO;

@Controller
public class ScheduleController {

	@Autowired
	SpringBiz biz;
	
	
	@RequestMapping("/toTest.do")
	public String toTest() {
		return "../../gnb";
	}

	@RequestMapping("/toSchedule.do")
	public String toSchdule(HttpSession session) {
		return "Schedule/Schedule";
	}
	
	@RequestMapping("/initSchedule.do")
	public String initSchdule(HttpSession session) {
		session.setAttribute("Schedule_List", null);
		return "redirect:toSchedule.do";
	}
	
	@RequestMapping(value="/finSchedule.do", method=RequestMethod.POST)
	public String finSchdule(@RequestParam("stitle22") String stitle22, HttpSession session) {
		ArrayList<ScheduleVO> list = (ArrayList<ScheduleVO>)session.getAttribute("Schedule_List");
		
		Date date = new Date();
		SimpleDateFormat spdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		String title = spdf.format(date);
		
		
		list.get(0).setStitle(stitle22+" ("+title+"작성 )");
		if(session.getAttribute("Idcode")!=null) {
			for(ScheduleVO one : list) {
				one.setMid((String)session.getAttribute("Idcode"));
			}
		}
		biz.saveSchedule(list);
		return "redirect:toSchedule.do";
	}

	@RequestMapping("/setSchedule.do")
	public String setSchedule(@ModelAttribute srchResultVO srchres, HttpSession session) {
		try {
			srchres.setSlloc(URLDecoder.decode(srchres.getSlloc(),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String Idcode = (String)session.getAttribute("Idcode");
		if(Idcode==null) {
			long randomNumber = Math.round(Math.random()*9000)+1000;
			srchres.setMid("9999"+randomNumber);
		} else {
			srchres.setMid(Idcode);
		}
		int res = biz.insertScheduleLog(srchres);
		
		if(res > 0) {
			ScheduleVO schedule = new ScheduleVO(srchres);
			res = biz.getScheduleInfo(schedule);
			int tH=-10;
			if(schedule.getSchedule_start()=="") {
				String time = schedule.getClstart();
				int H = Integer.parseInt(time.split("[:]")[0])-2;
				tH=H;
				int M = 0;
				Date date = null;
				try {
					date = new SimpleDateFormat("HH:mm").parse(H+":"+M);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				schedule.setSchedule_start(new SimpleDateFormat("HH:mm").format(date));
			}
			if(!compareStringTime.compare(schedule.getSchedule_start(),schedule.getClstart())) {
				String time = schedule.getClstart();
				int H = Integer.parseInt(time.split("[:]")[0])-2;
				tH=H;
				int M = 0;
				Date date = null;
				try {
					date = new SimpleDateFormat("HH:mm").parse(H+":"+M);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				schedule.setSchedule_start(new SimpleDateFormat("HH:mm").format(date));
			}
			if(schedule.getSchedule_end()=="") {
				String time = schedule.getClend();
				int H = Integer.parseInt(time.split("[:]")[0])+2;
				if(H <= tH) {
					H+=24;
				}
				int M = 0;
				Date date = null;
				if(H>=24) {
					schedule.setSchedule_end(H+":"+M);
				} else {
					try {
						date = new SimpleDateFormat("HH:mm").parse(H+":"+M);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					schedule.setSchedule_end(new SimpleDateFormat("HH:mm").format(date));
				}
			}
			if(compareStringTime.compare(schedule.getSchedule_end(),schedule.getClend())) {
				String time = schedule.getClend();
				int H = Integer.parseInt(time.split("[:]")[0])+2;
				if(H <= tH) {
					H+=24;
				}
				int M = 0;
				Date date = null;
				if(H>=24) {
					schedule.setSchedule_end(H+":"+M);
				} else {
					try {
						date = new SimpleDateFormat("HH:mm").parse(H+":"+M);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					schedule.setSchedule_end(new SimpleDateFormat("HH:mm").format(date));
				}
			}
			ArrayList<ScheduleVO> scheduleList = null;
			if(session.getAttribute("Schedule_List")==null) {
				scheduleList = new ArrayList<>();
				scheduleList.add(schedule);
			} else {
				scheduleList = (ArrayList<ScheduleVO>)session.getAttribute("Schedule_List");
				scheduleList.add(schedule);
				String p_start="";
				String p_end="";
				String p_nick="";
				for(ScheduleVO one : scheduleList) {
					if(p_nick=="") {
						p_nick=one.getMnick();
					} else if(p_nick!=one.getMnick()) {
						p_nick=one.getMnick();
					}
					if(p_start=="") {
						p_start=one.getSchedule_start();
					} else {
						int first_hour = Integer.parseInt(p_start.split("[:]")[0]);
						int first_min = Integer.parseInt(p_start.split("[:]")[1]);
						int second_hour = Integer.parseInt(schedule.getSchedule_start().split("[:]")[0]);
						int second_min = Integer.parseInt(schedule.getSchedule_start().split("[:]")[1]);
						
						if(second_hour < first_hour) {
							p_start=one.getSchedule_start();
						} else if(second_hour == first_hour) {
							if(second_min <= first_min) {
								p_start=one.getSchedule_start();
							}
						}
					}
					if(p_end=="") {
						p_end=one.getSchedule_end();
					} else {
						int first_hour = Integer.parseInt(p_end.split("[:]")[0]);
						int first_min = Integer.parseInt(p_end.split("[:]")[1]);
						int second_hour = Integer.parseInt(schedule.getSchedule_end().split("[:]")[0]);
						int second_min = Integer.parseInt(schedule.getSchedule_end().split("[:]")[1]);
						
						if(second_hour > first_hour) {
							p_end=one.getSchedule_end();
						} else if(second_hour == first_hour) {
							if(second_min >= first_min) {
								p_end=one.getSchedule_end();
							}							
						}
					}
				}
				scheduleList.get(0).setMnick(p_nick);
				scheduleList.get(0).setSchedule_start(p_start);
				scheduleList.get(0).setSchedule_end(p_end);
			}
			session.setAttribute("Schedule_List", scheduleList);
			return "redirect:toSchedule.do";
		}
		
		return "Schedule/Schedule";
	}
	
	@RequestMapping(value="/setLocation.do", produces="application/json; charset=UTF-8", method=RequestMethod.POST)
	public @ResponseBody ModelAndView setLocation(@RequestParam("location") String location) {
		return new ModelAndView("../../map3","location",location);
	}
	
	@RequestMapping(value="/srchSchedule.do", produces="application/json; charset=UTF-8", method=RequestMethod.POST)
	public @ResponseBody ModelAndView srchSchedule(@ModelAttribute srchOptionVO srchoptionvo) {
		List<SrchClVO> classlist = null;
		if(!srchoptionvo.getStime().equals("")) {
			srchoptionvo.setStime(srchoptionvo.getStime().replace(" ",""));
		}
		if(!srchoptionvo.getEtime().equals("")) {
			srchoptionvo.setEtime(srchoptionvo.getEtime().replace(" ",""));			
		}
		if(srchoptionvo.getCl().equals("")) {
			classlist = biz.getClasslist2(srchoptionvo);			
		} else {
			classlist = biz.getClasslist(srchoptionvo);			
		}
		ModelAndView mav = new ModelAndView("../../map","location",srchoptionvo.getLocation());
		mav.addObject("message","");
		if(classlist.isEmpty()) {
			mav.addObject("message","검색하신 조건에 해당하는 수업이 없습니다. 다른 조건으로 검색하여주시기 바랍니다");
		}
		mav.addObject("classlist",classlist);
		mav.addObject("srchOption",srchoptionvo);
		return mav;
	}
	
	@RequestMapping(value="/seeDetails.do")
	public ModelAndView seeDetailofAcademy(@RequestParam("aid") int aid) {
		HashMap<String, Object> res_map = (HashMap<String, Object>)biz.getAcatInfo(aid);
		System.out.println(res_map);
		return new ModelAndView("Schedule/AcademyInfo","res_map",res_map);
	}
	
	@RequestMapping(value="/insertClcmt.do")
	public ModelAndView insertClcmt(@RequestParam("star-input") int clcscore,
										@RequestParam("aid") int aid,
										@RequestParam("clid") int clid,
										@RequestParam("mid") int mid,
										@RequestParam("clcctx") String clcctx) {
		ClcmtVO ins_vo = new ClcmtVO();
		ins_vo.setClcscore(clcscore);
		ins_vo.setClid(clid);
		ins_vo.setMid(mid);
		ins_vo.setClcctx(clcctx);
		biz.insertClcmt(ins_vo);
		return new ModelAndView("redirect:seeDetails.do", "aid", aid);
	}
}
