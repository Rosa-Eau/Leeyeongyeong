package security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					   "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class AdminTests {

	@Autowired
	private PasswordEncoder pwencoder;
	
	@Autowired
	private DataSource ds;
	
//	@Test
//	public void testInsertAdmin() {
//		
//		String sql = "insert into tbl_admin(id, password) values(?,?)";
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(sql);
//			
//			pstmt.setString(1, "adminOJS");
//			pstmt.setString(2, pwencoder.encode("lovemelikeyoudo"));
//			
//			pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			if(pstmt != null) {try {
//				pstmt.close(); 
//			} catch (Exception e) {}}
//			if(con != null) {try {
//				con.close();
//			} catch (Exception e) {}}
//		}
//		
//		log.info("success");
//	}
	
	@Test
	public void testInsertAuth() {
		
		String sql = "insert into tbl_authorities (id, authority) values (?,?)";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "adminOJS");
			pstmt.setString(2, "ROLE_ADMIN");
			
			pstmt.executeUpdate();
			
			log.info("success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try {
				pstmt.close(); 
			} catch (Exception e) {}}
			if(con != null) {try {
				con.close();
			} catch (Exception e) {}}
		}
	}
	
}