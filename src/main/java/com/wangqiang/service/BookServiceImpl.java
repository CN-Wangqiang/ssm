package com.wangqiang.service;

import com.wangqiang.dao.BookMapper;
import com.wangqiang.pojo.Books;
import java.util.List;

/**
 * @version : V1.0
 * @ClassName: BookServiceImpl
 * @Description: TODO
 * @Auther: wangqiang
 * @Date: 2020/2/19 14:30
 */

public class BookServiceImpl implements BookService {

    private BookMapper bookMapper;

    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    public int addBook(Books book) {
        return bookMapper.addBook(book);
    }

    public int deleteBookById(int id) {
        return bookMapper.deleteBookById(id);
    }

    public int updateBook(Books book) {
        return bookMapper.updateBook(book);
    }

    public Books queryBookById(int id) {
        return bookMapper.queryBookById(id);
    }

    public List<Books> queryAllBook() {
        return bookMapper.queryAllBook();
    }
}
