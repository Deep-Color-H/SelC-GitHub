package SelCDB.spring.BIZ;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import SelCDB.spring.DAO.SpringDao;
import SelCDB.spring.DAO.SpringSrchDao;
import SelCFunction.processImg;
import SelCVO.ClcmtVO;
import SelCVO.LoginVO;
import SelCVO.ScheduleVO;
import SelCVO.SigninVO;
import SelCVO.SrchClVO;
import SelCVO.srchOptionVO;
import SelCVO.srchResultVO;

@Service
public class SpringBiz {

	@Autowired
	SpringDao dao;

	@Autowired
	SpringSrchDao srchdao;

	public String Login(LoginVO loginvo) {
		LoginVO res = dao.login(loginvo);
		if (res == null) {
			return "false";
		}
		return res.getMid();

	}

	public boolean searchEmail(String email) {
		List<String> list = dao.searchEmail(email);
		if (!list.isEmpty()) {
			return true;
		}
		return false;
	}

	public int insertMember(SigninVO signinvo) {

		if(signinvo.getMchemail() == null) {
			signinvo.setMchemail("N");
		}
		if(signinvo.getMpfimg() != null) {
			signinvo.setMpfimg	(processImg.inputImg(signinvo.getMpfimg_org(), signinvo.getMem()));
		}
		// 1. 해당되는 email를 이용 image를 저장하고 이 PATH를 저장한다.
		HashMap<String, Object> signMap = new HashMap<>();
		signMap.put("mem", signinvo.getMem());
		signMap.put("mpw", signinvo.getMpw());
		signMap.put("mname", signinvo.getMname());
		signMap.put("mnick", signinvo.getMnick());
		signMap.put("mpfimg", signinvo.getMpfimg());
		signMap.put("mage", signinvo.getMage());
		signMap.put("maddr", signinvo.getMaddr());
		signMap.put("mchemail", signinvo.getMchemail());

		int res = dao.insertMember(signMap);

		if (res > 0)
			dao.getMid(signinvo);

		return res;
	}

	public LoginVO setTempPW(String mem) {
		String temp_pw = UUID.randomUUID().toString().substring(0, 8);
		LoginVO setTPw = new LoginVO();
		setTPw.setMem(mem);
		setTPw.setMpw(temp_pw);
		int res = dao.setTempPw(setTPw);
		if (res > 0) {
			return setTPw;
		}
		return null;
	}

	public SigninVO ModifyView(int mid) {

		SigninVO res = dao.ViewList(mid);

		return res;
	}

	public int updateUser(SigninVO signinvo) {
		HashMap<String, Object> updatemap = new HashMap<>();
		updatemap.put("mid", Integer.parseInt(signinvo.getMid()));
		updatemap.put("mpw", signinvo.getMpw());
		updatemap.put("mnick", signinvo.getMnick());
		updatemap.put("maddr", signinvo.getMaddr());
		updatemap.put("mage", signinvo.getMage());
		String YoN = signinvo.getMchemail();
		
		if(signinvo.getMchemail() == null) {
			updatemap.put("mchemail", "N");
		}else {
			updatemap.put("mchemail", "Y");
		}
		
		if(!signinvo.getMpfimg_org().isEmpty()) {
			
			updatemap.put("mpfimg", processImg.inputImg(signinvo.getMpfimg_org(), signinvo.getMem()));
		}else if(signinvo.getMpfimg() != null) {
			updatemap.put("mpfimg", signinvo.getMpfimg());
		}
		
		return dao.UpdateUser(updatemap);

	}

	public String deleteMember(String mid) {
		String res = dao.deleteMember(mid);
		if (res == null) {
			return "회원정보 삭제에 실패하였습니다.";
		} else {
			return res;
		}

	}
	
	public List<SrchClVO> getClasslist(srchOptionVO srchoption) {
		List<SrchClVO> res = null;
		try {
			res = srchdao.getCatList(srchoption.getCl(),srchoption.getCat());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public List<SrchClVO> getClasslist2(srchOptionVO srchoption) {
		List<SrchClVO> res = null;
		try {
			res = srchdao.getCatList2(srchoption.getCat());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(res);
		return res;
	}

	public int insertScheduleLog(srchResultVO srchres) {
		int res = dao.insertLog(srchres);
		return res;
	}

	public int getScheduleInfo(ScheduleVO schedule) {
		ScheduleVO res;
		if(schedule.getMid().length() < 8) {			
			res = srchdao.getScheduleInfo(schedule);
			schedule.setMnick(res.getMnick());
		} else {
			res = srchdao.getScheduleInfo2(schedule);
			schedule.setMnick("비회원");
		}
		schedule.setAname(res.getAname());
		schedule.setAloc(res.getAloc());
		schedule.setClname(res.getClname());
		schedule.setClstart(res.getClstart());
		schedule.setClend(res.getClend());
		return 1;
	}
	
public Map<String, Object> main_view_list(){
        
        
        Map<String, Object> res = dao.main_view_list();
        
        
        return res;
    }

	public int saveSchedule(ArrayList<ScheduleVO> list) {
		int spreid = 0;
		for(ScheduleVO one : list) {
			one.setSpreid(spreid);
			spreid = srchdao.insertSchedule(one);
		}
		
		return 1;
	}

	public Map<String, Object> getScheduleList(int mid) {
		
		//결과를 담고 리턴시킬 곳 (ScheduleList : 스케쥴 목록, STitleList : 제목목록
		Map<String, Object> schedule_all = srchdao.getScheduleList(mid);

		// 1. 스케쥴을 스케쥴끼리 묶은 것을 모아놓은 ArrayList
		HashMap<String, ArrayList<ScheduleVO>> rtrn_schedule = new HashMap<>();
		// 2. 아직 묶이지 않은 스케쥴
		ArrayList<ScheduleVO> schedule_res = (ArrayList<ScheduleVO>)schedule_all.get("ScheduleList");
		// 3. 1에 넣을 임시 공간
		ArrayList<ScheduleVO> schedule_temp = new ArrayList<>();
		
		int check_spreid = 0;
		String keytitle = null;
		for(ScheduleVO one : schedule_res) {
			if(one.getStitle()!=null) {
				if(keytitle!=null) {
					rtrn_schedule.put(keytitle,schedule_temp);
					check_spreid=0;
					keytitle = null;
				}
				schedule_temp = new ArrayList<>();
				schedule_temp.add(one);
				check_spreid = one.getSid();
				keytitle = one.getStitle();
			} else {
				if(one.getSpreid()==check_spreid) {
					schedule_temp.add(one);
					check_spreid = one.getSid();
				}
			}
		}
		rtrn_schedule.put(keytitle,schedule_temp);
		schedule_all.put("ScheduleList", rtrn_schedule);
		return schedule_all;
	}

	public int getScheduleId(String stitle) {
		
		return dao.getScheduleId(stitle);
	}

	public ArrayList<ScheduleVO> getSchedule(int sid) {
		ArrayList<ScheduleVO> res = new ArrayList<>();
		ScheduleVO obj = dao.getSPSchedule(sid);
		while(obj!=null){
			sid = obj.getSid();
			res.add(obj);
			obj = dao.getSchedule(sid);
		}
		return res;
	}
//	08-06 업데이트
	public String getImagePath(int mid) {
		
		String res = dao.getPath(mid);
		
		return res;
	}
	
	public Map getAcatInfo(int aid) {
		HashMap<String, Object> res = dao.getAcatinfo(aid);
		
		ArrayList<ClcmtVO> clcmt_list = (ArrayList<ClcmtVO>)res.get("clcmt_list");
		ArrayList<ClcmtVO> temp_list = new ArrayList<>();
		HashMap<Integer, ArrayList<ClcmtVO>> clcmt_map = new HashMap<>();
		
		int clcid = 0;
		for(ClcmtVO one : clcmt_list) {
			if(clcmt_map.get(one.getClid())==null) {
				temp_list = new ArrayList<>();
			} else {
				temp_list = clcmt_map.get(one.getClid());
			}
			temp_list.add(one);
			clcmt_map.put(one.getClid(), temp_list);				
		}
		res.put("clcmt_list", clcmt_map);
		return res;
	}

	public int insertClcmt(ClcmtVO ins_vo) {
		int res = dao.insertCLCmt(ins_vo);
		return res;
	}
}
