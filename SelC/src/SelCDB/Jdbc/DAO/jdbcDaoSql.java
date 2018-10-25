package SelCDB.Jdbc.DAO;

public interface jdbcDaoSql {
	String board_listview = "CALL BOARD_LISTVIEW(?,?,?,?,?)";
	String board_qalistview = "CALL QABOARD_LISTVIEW(?, ?, ?, ?)";
	String board_view ="CALL BOARD_VIEW( ?, ? ,?)";
	String qaboard_view = "CALL QABOARD_VIEW(?, ? ,?)";
	String getmidbybid = "SELECT MID FROM BOARD WHERE BID=?";
	String getmidbybid_2 = "SELECT MID FROM QABOARD WHERE BID=?";
	String getmidbybid_3= "SELECT MID FROM SCHEDULE WHERE BID =? ";
	String delete_post = "CALL DELETE_POST(?, ?)";
	String deletecmtbycid = "DELETE FROM CMT WHERE CID = ?";
	String delete_qa_cmt = "CALL DELETE_QA_CMT(?, ?)";
	String delete_schedule = "CALL DELETE_SCHEDULE(?)";
	String inert_board = "CALL INERTBOARD(?, ?, ?, ?, ?)";
	String insert_board = "INSERT INTO BOARD(BCATID, MID, BTITLE, BCTX, BIMG) VALUES(?, ?, ?, ?, ?)";
	String insert_scheduleboard = "INSERT INTO BOARD(BCATID, MID, SID, BTITLE, BCTX, BIMG) VALUES(?, ?, ?, ?, ?, ?)";
	String insert_qaboard = "INSERT INTO QABOARD(MID, BTITLE, BCTX) VALUES(?, ?, ?)";
	String insert_cmt = "INSERT INTO CMT(CID, MID, BID, CCTX) VALUES(CMT_SEQ.NEXTVAL,?,?,?)";
	String insert_cmt_2 = "INSERT INTO CMT(CID, MID, QABID, CCTX) VALUES(CMT_SEQ.NEXTVAL,?,?,?)";
	String update_board = "UPDATE BOARD SET BTITLE =?, BCTX =?, BIMG =? WHERE BID = ?";
	String update_board_2 = "UPDATE QABOARD SET BTITLE =?, BCTX =? WHERE BID = ?";
	String recommend_board = "UPDATE BOARD SET BRCM =BRCM+1 WHERE BID = ?";
	String recommend_cmt = "UPDATE CMT SET CRCM =CRCM+1 WHERE CID =?";
	String board_srch = "CALL BOARD_SRCH(?,?,?,?,?,?,?)";
	String qaboard_srch = "CALL QABOARD_SRCH(?,?,?,?,?,?)";
}
