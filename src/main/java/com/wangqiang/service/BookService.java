package com.wangqiang.service;

import com.wangqiang.dto.PaginationDTO;
import com.wangqiang.pojo.Books;
import org.apache.ibatis.annotations.Param;

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

    PaginationDTO queryAllBook(Integer curPage, Integer pageSize);

    int queryBookCountByName(@Param(value = "bookName")String bookName);

    PaginationDTO queryBookByName(String bookName,Integer curPage, Integer pageSize);
}
