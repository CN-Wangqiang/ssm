package com.wangqiang.service;

import com.wangqiang.pojo.Books;
import java.util.List;

/**
 * @version : V1.0
 * @ClassName: BookService
 * @Description: TODO
 * @Auther: wangqiang
 * @Date: 2020/2/19 14:29
 */
public interface BookService {
    int addBook(Books book);

    int deleteBookById( int id);

    int updateBook(Books book);

    Books queryBookById(int id);

    List<Books> queryAllBook();
}
