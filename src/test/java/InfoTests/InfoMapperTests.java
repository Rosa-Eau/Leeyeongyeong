package InfoTests;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lee.admin.domain.InfoDTO;
import com.lee.admin.mapper.InfoMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class InfoMapperTests {
	
	@Autowired
	private InfoMapper infoMapper;
	
//	@Test
//	public void testList() {
//		infoMapper.list().forEach(text -> log.info(text));
//	}
//	
//	
//	@Test
//	public void testInsert() {
//		
//		InfoDTO info = new InfoDTO();
//		
//		info.setTitle("Education");
//		info.setContent("2012 - 2015        Seoul Art High School\n"
//				+ "2015 -                   Chugye University For Art");
//		
//		
//		infoMapper.register(info);
//		
//		log.info(info);
//	}
//	
	
//	@Test
//	public void testUpdate() {
//		
//		InfoDTO info = new InfoDTO();
//		
//		info.setTno(1);
//		info.setTitle("Art");
//		info.setContent("love");
//		
//		int count = infoMapper.modify(info);
//		log.info("Update Count: " + count);
//	}
	
//	@Test
//	public void testDelete() {
//		
//		log.info("DELETE COUNT : " + infoMapper.delete(1));
//	}
}
