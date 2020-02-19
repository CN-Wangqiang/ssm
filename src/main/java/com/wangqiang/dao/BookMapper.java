package com.wangqiang.dao;

import com.wangqiang.pojo.Books;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * @version : V1.0
 * @ClassName: BookMapper
 * @Description: TODO
 * @Auther: wangqiang
 * @Date: 2020/2/19 14:11
 */
public interface BookMapper {
    int addBook(Books book);
    int deleteBookById(@Param(value = "bookId") int id);
    int updateBook(Books book);
    Books queryBookById(@Param(value = "bookId")int id);
    List<Books> queryAllBook();
}
