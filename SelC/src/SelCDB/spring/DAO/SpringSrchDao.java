package SelCDB.spring.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.cursor.Cursor;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import SelCVO.ScheduleVO;
import SelCVO.SrchClVO;
import SelCVO.srchResultVO;

@Repository
public class SpringSrchDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List<SrchClVO> getCatList(String CLCATID, String ACATID) throws SQLException {
		
		SqlSession session = factory.openSession();
		
		Map keymap = new HashMap();
		keymap.put("clcatid", CLCATID);
		keymap.put("acatid", ACATID);
		
		session.selectOne("srchCl.srchCl1", keymap);
		return (List<SrchClVO>) keymap.get("cursor");
	}
	
	public List<SrchClVO> getCatList2(String ACATID) throws SQLException {
		
		SqlSession session = factory.openSession();
		Map keymap = new HashMap();
		keymap.put("acatid", ACATID);
		
		session.selectOne("srchCl.srchCl2", keymap);
		ArrayList<SrchClVO> list = (ArrayList)keymap.get("cursor");
		return list;
	}

	public int insertSchedule(ScheduleVO schedule) {
		
		SqlSession session = factory.openSession();
		
		Map keymap = new HashMap();
		keymap.put("clid", schedule.getClid());
		keymap.put("mid", schedule.getMid());
		keymap.put("spreid", schedule.getSpreid());
		keymap.put("stitle", schedule.getStitle());
		keymap.put("schedule_start", schedule.getSchedule_start());
		keymap.put("schedule_end", schedule.getSchedule_end());
		
		session.selectOne("schedule.insertSchedule",keymap);
		schedule.setSid((int)keymap.get("sid"));
		session.commit();
		session.close();
		
		return schedule.getSid();
	}

	public ScheduleVO getScheduleInfo(ScheduleVO schedule) {
		SqlSession session = factory.openSession();
		Map keymap = new HashMap();
		keymap.put("clid", schedule.getClid());
		keymap.put("mid", schedule.getMid());
		session.selectOne("schedule.getScheduleInfo",keymap);
		return ((ArrayList<ScheduleVO>)keymap.get("cursor")).get(0);
	}
	
	public ScheduleVO getScheduleInfo2(ScheduleVO schedule) {
		SqlSession session = factory.openSession();
		Map keymap = new HashMap();
		keymap.put("clid", schedule.getClid());
		session.selectOne("schedule.getScheduleInfo2",keymap);
		return ((ArrayList<ScheduleVO>)keymap.get("cursor")).get(0);
	}
	
	public HashMap<String, Object> getScheduleList(int mid) {
		SqlSession session = factory.openSession();
		
		Map<String, Object> keymap = new HashMap<>();
		keymap.put("mid", mid);
		session.selectOne("schedule.getScheduleList", keymap);
		
		HashMap<String, Object> res_map = new HashMap<>();
		res_map.put("ScheduleList", keymap.get("schedule_cur"));
		res_map.put("STitleList", keymap.get("stitle_cur"));
		
		
		return res_map;
	}
	
}
