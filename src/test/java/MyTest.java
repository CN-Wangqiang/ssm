import com.wangqiang.pojo.Books;
import com.wangqiang.service.BookService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

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
        for (Books books : bookServiceImpl.queryAllBook()) {
            System.out.println(books);

        }
    }
}
