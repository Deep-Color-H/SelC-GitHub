package SelCDB.spring.DAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import SelCVO.AcatinfoVO;
import SelCVO.BoardVO;
import SelCVO.ClcmtVO;
import SelCVO.LoginVO;
import SelCVO.ScheduleVO;
import SelCVO.SigninVO;
import SelCVO.srchResultVO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

@Repository
public class SpringDao {

	@Autowired
	SqlSessionFactory factory;

	public LoginVO login(LoginVO loginvo) {
		System.out.println(factory);
		SqlSession session = factory.openSession();
		LoginVO res = session.selectOne("login.login", loginvo);
		session.close();
		return res;
	}

	/*
	 * public LoginVO login(LoginVO loginvo) { System.out.println(factory);
	 * SqlSession session = factory.openSession(); LoginVO res =
	 * session.selectOne("login.login", loginvo);
	 * loginvo.setMid(session.selectOne("signin.getMid",loginvo.getMem()));
	 * session.close(); return res; }
	 */
	public List<String> searchEmail(String mem) {
		SqlSession session = factory.openSession();
		List<String> res = session.selectList("signin.checkemail", mem);
		session.close();
		return res;
	}

	public int insertMember(HashMap<String, Object> signMap) {
		SqlSession session = factory.openSession();
		try {
			session.selectOne("signin.insertMem", signMap);
			session.commit();
			session.close();
			return 1;
		} catch (Exception e) {
			session.rollback();
			session.close();
			e.printStackTrace();
		}
		session.close();
		return 0;
	}

	public void getMid(SigninVO signinvo) {
		SqlSession session = factory.openSession();
		signinvo.setMid(session.selectOne("signin.getMid", signinvo.getMem()));
		session.commit();
		session.close();
	}

	public int setTempPw(LoginVO setTPw) {
		SqlSession session = factory.openSession();
		try {
			int res = session.update("login.find_password", setTPw);
			if (res > 0) {
				session.commit();
			}
			session.close();
			return res;
		} catch (Exception e) {
			session.rollback();
			session.close();
			e.printStackTrace();
		}
		session.close();
		return 0;
	}

	// ---------------------------------------------------------------------------------------------------------
	public int UpdateUser(HashMap<String, Object> updatemap) {

		SqlSession session = factory.openSession();
		
		try {
			session.update("signin.updateMem", updatemap);
			session.commit();
			session.close();

			return 1;
		} catch (Exception e) {
			session.rollback();
			session.close();
			e.printStackTrace();
		}
		session.close();

		return 0;
	}

	public SigninVO ViewList(int mid) {
		SqlSession session = factory.openSession();

		SigninVO res = session.selectOne("signin.modifyview", mid);

		return res;
	}
	
	public String deleteMember(String mid) {
        SqlSession session = factory.openSession();
        String res = null;
        Map keymap = new HashMap();
        keymap.put("mid", mid);
        try {
            session.selectOne("signin.deleteMem",keymap);
            session.commit();
            session.close();            
        } catch(Exception e) {
            session.rollback();
            session.close();
            e.printStackTrace();
        }
        session.close();
        return (String)keymap.get("mname");
    }

	public int insertLog(srchResultVO srchres) {
		SqlSession session = factory.openSession();
		int res =session.insert("schedule.insertlog",srchres);
		if (res >0) {
			session.commit();
		} else {
			session.rollback();
		}
		session.close();
		return res;
	}

	public Map<String, Object> main_view_list(){
        SqlSession session = factory.openSession();
        
        Map<String, Object> res = new HashMap<>();
        
        List<BoardVO> sch_list = session.selectList("main.view_sch_list");
        List<BoardVO> board_list = session.selectList("main.view_board_list");
        
        res.put("sch_list", sch_list);
        res.put("board_list", board_list);
        
        session.close();
        
        return res;
    }
	
	public int getScheduleId(String stitle) {
		SqlSession session = factory.openSession();
		
		int sid = session.selectOne("schedule.ScheduleId",stitle);
        session.close();

		return sid;
	}

	public ScheduleVO getSchedule(int spreid) {
		SqlSession session = factory.openSession();
		
		Map<String, Object> keymap = new HashMap<>();
		keymap.put("spreid", spreid);
		session.selectOne("schedule.neSchedule",keymap);
		if(!((ArrayList<ScheduleVO>)keymap.get("schedule_cur")).isEmpty()) {
			ScheduleVO schedule = ((ArrayList<ScheduleVO>)keymap.get("schedule_cur")).get(0); 
			session.close();
			return schedule;
		}
		
		session.close();
		return null;
	}

	public ScheduleVO getSPSchedule(int sid) {
		
		SqlSession session = factory.openSession();
		
		Map<String, Object> keymap = new HashMap<>();
		keymap.put("sid", sid);
		session.selectOne("schedule.spSchedule",keymap);
		
		ScheduleVO schedule = ((ArrayList<ScheduleVO>)keymap.get("schedule_cur")).get(0); 
        session.close();

		return schedule;
	}
	
//	08-06 업데이트
	public String getPath(int mid) {
		
		SqlSession session = factory.openSession();
		String res = session.selectOne("schedule.getpath", mid);
		session.close();
		return res;
	}

	public HashMap<String, Object> getAcatinfo(int aid) {
		SqlSession session = factory.openSession();
		session.update("schedule.gainAhit", aid);
		List<Object> res = session.selectList("schedule.getAcatInfo", aid);
		ArrayList clcmt_list = (ArrayList)session.selectList("schedule.getClcmt",aid);
		
		HashMap<Integer, ArrayList<ClcmtVO>> clcmt_map = new HashMap<>();
		
		HashMap<String, Object> res_map = new HashMap<>();
		res_map.put("acatinfo", res);
		res_map.put("clcmt_list",clcmt_list);
		
		session.close();
		return res_map;
	}
	
	public int insertCLCmt(ClcmtVO clcmtvo) {
		SqlSession session = factory.openSession();
		int res = session.insert("schedule.insertCLCmt", clcmtvo);
		session.commit();
		session.close();
		return res;
	}

	public int deleteCLCmt(int CLCID) {
		SqlSession session = factory.openSession();
		int res = session.delete("schedule.deleteCLCmt", CLCID);
		session.commit();
		session.close();
		return res;
	}

}
