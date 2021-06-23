package InfoTests;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lee.admin.domain.InfoDTO;
import com.lee.admin.service.IInfoService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class InfoServiceTests {

	@Autowired
	private IInfoService service;
	
//	@Test
//	public void testExist() {
//		
//		log.info(service);
//		assertNotNull(service);
//	}
	
//	@Test
//	public void register() throws Exception {
//		
//		InfoDTO info = new InfoDTO();
//		
//		info.setTitle("service test");
//		info.setContent("register test");
//		
//		service.register(info);
//		
//		log.info(info.getTno());
//		
//	}
//	
	@Test
	public void testList() throws Exception {
		log.info(service.list());
	}
	
//	@Test
//	public void testDelete() throws Exception {
//		
//		log.info("REMOVE : " + service.delete(2));
//	}
	
//	@Test
//	public void testUpdate() throws Exception {
//		
//		InfoDTO info = service.read(1);
//		
//		if(info == null) {
//			return;
//		}
//		
//		info.setTitle("Modify Service Test");
//		log.info("MODIFYRESULT : " + service.modify(info));
//		
//		
//		
//	}
}
