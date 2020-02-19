package com.wangqiang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @version : V1.0
 * @ClassName: Books
 * @Description: TODO
 * @Auther: wangqiang
 * @Date: 2020/2/19 14:06
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {
    private int bookId;
    private String bookName;
    private int bookCounts;
    private String detail;
}
