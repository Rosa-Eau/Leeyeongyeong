package InfoTests;

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
public class InfoControllerTests {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mock;
	
	@Before
	public void setup() {
		this.mock = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Test
//	public void testList() throws Exception{
//		
//		log.info(mock.perform(MockMvcRequestBuilders
//				.get("/admin/info/main"))
//				.andReturn()
//				.getModelAndView()
//				.getModelMap());
//	}
//	
//	@Test
//	public void testRegister () throws Exception {
//		
//		String resultPage = mock.perform(MockMvcRequestBuilders.post("/admin/info/register")
//				.param("title", "Controller Test")
//				.param("content", "Test1"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(resultPage);
//		
//	}
//	
//	@Test
//	public void modifyWithRead() throws Exception {
//		
//		log.info(mock.perform(MockMvcRequestBuilders.post("/admin/info/modify")
//				.param("tno", "3")
//				.param("title", "Modify Title")
//				.param("content", "Modify content"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName());
//	}
//	
//	@Test
//	public void testDelete() throws Exception {
//		String resultPage = mock.perform(MockMvcRequestBuilders.post("/admin/info/remove")
//				.param("tno", "2"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(resultPage);
//	}
//	
//	
	
	
	
}
