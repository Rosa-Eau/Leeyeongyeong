package WorkTests;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class WorkControllerTests {

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mock;
	
	@Before
	public void setup() {
		this.mock = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Test
//	public void testListWithPaiging() throws Exception {
//		
//		log.info(mock.perform(MockMvcRequestBuilders
//				.get("/admin/work/main")
//				.param("pageNum", "2")
//				.param("amount", "3"))
//				.andReturn()
//				.getModelAndView()
//				.getModelMap());
//	}
	
	@Test
	public void testRegister () throws Exception {
	
		String resultPage = mock.perform(MockMvcRequestBuilders.post("/admin/work/register")
				.param("title", "이거 꺠지냐?")
				.param("content", "아니지?")
				.param("workdate", "2021-02-01"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);

		
	}
	
//	@Test
//	public void modifyWithRead() throws Exception {
//		
//		log.info(mock.perform(MockMvcRequestBuilders.post("/admin/work/modify")
//				.param("wno", "3")
//				.param("title", "Modify Title")
//				.param("content", "Modify content")
//				.param("workdate", "2021-02-01"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName());
//	}
	
//	@Test
//	public void testDelete() throws Exception {
//		String resultPage = mock.perform(MockMvcRequestBuilders.post("/admin/work/remove")
//				.param("wno", "9"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(resultPage);
//	}
	
	
	
	
	
}
