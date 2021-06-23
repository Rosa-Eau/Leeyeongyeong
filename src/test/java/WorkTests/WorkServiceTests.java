package WorkTests;

import static org.junit.Assert.assertNotNull;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.WorkDTO;
import com.lee.admin.service.IWorkService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class WorkServiceTests {

	@Autowired
	private IWorkService service;
	
//	@Test
//	public void testExist() {
//		
//		log.info(service);
//		assertNotNull(service);
//	}
//	
//	@Test
//	public void register() throws Exception {
//		
//		WorkDTO work = new WorkDTO();
//		
//		Date workdate = Date.valueOf("2020-03-15");
//		
//		work.setTitle("service test");
//		work.setContent("register test");
//		work.setWorkdate(workdate);
//		
//		service.register(work);
//		
//		log.info(work.getWno());
//		
//	}
	
//	@Test
//	public void testList() throws Exception {
//		
//		service.list(new Criteria(1, 10)).forEach(work -> log.info(work));
//	}
	
//	@Test
//	public void testDelete() throws Exception {
//		
//		log.info("REMOVE : " + service.delete(2));
//	}
	
//	@Test
//	public void testUpdate() throws Exception {
//		
//		WorkDTO work = service.read(6);
//		
//		if(work == null) {
//			return;
//		}
//		
//		work.setTitle("Modify Service Test");
//		log.info("MODIFYRESULT : " + service.modify(work));
//		
//		
//		
//	}
}
