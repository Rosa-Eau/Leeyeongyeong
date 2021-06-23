package WorkTests;

import java.sql.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lee.admin.domain.Criteria;
import com.lee.admin.domain.WorkDTO;
import com.lee.admin.mapper.WorkMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class WorkMapperTests {
	
	@Autowired
	private WorkMapper wMapper;
	

	@Test
	public void testInsert() {
		
		WorkDTO work = new WorkDTO();
		
		Date workdate = Date.valueOf("2020-03-15");
			
		work.setTitle("안녕");
		work.setContent("제발 살려줘");
		work.setWorkdate(workdate);
		
		wMapper.register(work);
		
		log.info(work);
	}
	
//	
//	@Test
//	public void testPaging() {
//		
//		Criteria cri = new Criteria();
//		
//		cri.setPageNum(3);
//		cri.setAmount(5);
//		
//		List<WorkDTO> list = wMapper.listWithPaging(cri);
//		
//		list.forEach(work -> log.info(work));
//	}
	
//	@Test
//	public void testUpdate() {
//		
//		WorkDTO work = new WorkDTO();
//		
//		Date workdate = Date.valueOf("2021-06-14");
//		
//		work.setWno(1);
//		work.setTitle("Art");
//		work.setContent("love");
//		work.setWorkdate(workdate);
//		
//		int count = wMapper.modify(work);
//		log.info("UPDATE COUNT : " + count);
//	}
//	
//	@Test
//	public void testDelete() {
//		
//		log.info("DELETE COUNT : " + wMapper.delete(10));
//	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("M");
		cri.setType("TC");
		
		List<WorkDTO> list = wMapper.listWithPaging(cri);
		
		list.forEach(work -> log.info(work));
		
	}

}
