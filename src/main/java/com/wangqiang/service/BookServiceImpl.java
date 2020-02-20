package com.wangqiang.service;

import com.wangqiang.dao.BookMapper;
import com.wangqiang.dto.PaginationDTO;
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

    @Override
    public int queryBookCountByName(String bookName) {
        return bookMapper.queryBookCountByName(bookName);
    }

    public PaginationDTO queryAllBook(Integer curPage, Integer pageSize) {
        PaginationDTO<Object> paginationDTO = new PaginationDTO<>();
        Integer totalPage;
        Integer totalCount = bookMapper.queryBookCount();
        if(totalCount % pageSize == 0){
            totalPage = totalCount / pageSize;
        }else {
            totalPage = totalCount / pageSize + 1;
        }
        if (curPage < 1){
            curPage = 1;
        }
        if (curPage > totalPage){
            curPage = totalPage;
        }

        paginationDTO.setPagination(totalPage,curPage);
        Integer offset = pageSize * (curPage - 1);

        List<Books> books = bookMapper.queryAllBook(offset, pageSize);
        paginationDTO.setData(books);

        return paginationDTO;
    }

    public PaginationDTO queryBookByName(String bookName,Integer curPage, Integer pageSize) {
        PaginationDTO<Object> paginationDTO = new PaginationDTO<>();
        Integer totalPage;
        Integer totalCount = bookMapper.queryBookCountByName(bookName);
        if (totalCount.equals(0)) {
            return paginationDTO;
        }
        if(totalCount % pageSize == 0){
            totalPage = totalCount / pageSize;
        }else {
            totalPage = totalCount / pageSize + 1;
        }
        if (curPage < 1){
            curPage = 1;
        }
        if (curPage > totalPage){
            curPage = totalPage;
        }

        paginationDTO.setPagination(totalPage,curPage);
        Integer offset = pageSize * (curPage - 1);

        List<Books> books = bookMapper.queryBookByName(bookName,offset,pageSize);
        paginationDTO.setData(books);

        return paginationDTO;

    }
}
