import com.wangqiang.dto.PaginationDTO;
import com.wangqiang.pojo.Books;
import com.wangqiang.service.BookService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * @version : V1.0
 * @ClassName: MyTest
 * @Description: TODO
 * @Auther: wangqiang
 * @Date: 2020/2/19 17:41
 */
public class MyTest {
    @Test
    public  void test(){
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookServiceImpl = context.getBean("BookServiceImpl", BookService.class);
        PaginationDTO paginationDTO = bookServiceImpl.queryBookByName("", 0, 3);
        List<Books> books = paginationDTO.getData();
        for (Books book : books) {
            System.out.println(book);
        }
    }
    @Test
    public void test1(){
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookServiceImpl = context.getBean("BookServiceImpl", BookService.class);
        int count = bookServiceImpl.queryBookCountByName("");
        System.out.println(count);
    }
}
