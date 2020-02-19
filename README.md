# SSM框架整合
回顾了下Spring,SpringMVC,MyBatis框架整合，完善了一个小案例，包括基本的增删改查功能。
#### 环境要求

- IDEA
- MySQL 
- Tomcat
- Maven  
- 需要熟练掌握MySQL数据库，Spring，JavaWeb及MyBatis知识，简单的前端知识；

#### 数据库环境

创建一个存放书籍书籍的数据库表

```sql
CREATE DATABASE `ssmbuild`;

USE `ssmbuild`;

DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `bookID` INT(10) NOT NULL AUTO_INCREMENT COMMENT '书id',
  `bookName` VARCHAR(100) NOT NULL COMMENT '书名',
  `bookCounts` INT(11) NOT NULL COMMENT '数量',
  `detail` VARCHAR(200) NOT NULL COMMENT '描述',
  KEY `bookID` (`bookID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8

INSERT  INTO `books`(`bookID`,`bookName`,`bookCounts`,`detail`)VALUES 
(1,'Java',1,'从入门到放弃'),
(2,'MySQL',10,'从删库到跑路'),
(3,'Linux',5,'从进门到进牢');
```

#### 基本环境搭建

1. 新建一Maven项目！ ssmbuild ， 添加web的支持
2. 导入相关的pom依赖！

```xml
  <dependencies>
        <!--Junit-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
        </dependency>
        <!--数据库驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.19</version>
        </dependency>
        <!-- 数据库连接池 -->
        <dependency>
            <groupId>com.mchange</groupId>
            <artifactId>c3p0</artifactId>
            <version>0.9.5.2</version>
        </dependency>
        <!--Servlet - JSP -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>servlet-api</artifactId>
            <version>2.5</version>
        </dependency>
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>jsp-api</artifactId>
            <version>2.2</version>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>
        <!--Mybatis-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.2</version>
        </dependency>
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>2.0.2</version>
        </dependency>
        <!--Spring-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>5.1.9.RELEASE</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>5.1.9.RELEASE</version>
        </dependency>
    <!-- lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.8</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>
```

3. Maven资源过滤设置 

```xml
<build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
        </resources>
    </build>
```

4. **建立基本结构和配置框架**

- com.wangqiang.pojo

- com.wangqiang.dao

- com.wangqiang.service

- Mybatis-config.xml      

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE configuration
          PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
          "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <configuration>
  
  </configuration> 
  ```

- applicationContext.xml

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.springframework.org/schema/beans
          http://www.springframework.org/schema/beans/spring-beans.xsd">
  
  </beans>  
  ```

#### Mybatis层编写

1. 数据库配置文件 database.properties

   ```properties
   jdbc.driver=com.mysql.jdbc.Driver
   # 如果使用的是MySQL8.0+ ，增加一个时区的配置
   jdbc.url=jdbc:mysql://localhost:3306/ssmbuild?useSSL=true&useUnicode=true&characterEncoding=utf8&serverTimezone=UTC
   jdbc.username=root
   jdbc.password=root   
   ```

2. IDEA 关联数据库

3. 编写MyBatist的核心配置文件

   ```xml
   <?xml version="1.0" encoding="UTF-8" ?>
   <!DOCTYPE configuration
           PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
           "http://mybatis.org/dtd/mybatis-3-config.dtd">
   <configuration>
       <typeAliases>
           <package name="com.wangqiang.pojo"/>
       </typeAliases>
       <mappers>
           <mapper class="com.wangqiang.dao.BookMapper" ></mapper>
       </mappers>
   </configuration>
   ```

4. 编写数据库对应的实体类com.wangqiang.pojo.Books(使用lombok插件)

   ```java
   package com.wangqiang.pojo;
   
   import lombok.AllArgsConstructor;
   import lombok.Data;
   import lombok.NoArgsConstructor;
   
   @Data
   @AllArgsConstructor
   @NoArgsConstructor
   public class Books {
       private int bookId;
       private String bookName;
       private int bookCounts;
       private String detail;
   }
   ```

5. **编写Dao层的Mapper接口：BookMapper**

   ```java
   package com.wangqiang.dao;
   
   import com.wangqiang.pojo.Books;
   import org.apache.ibatis.annotations.Param;
   import java.util.List;
   
   public interface BookMapper {
       int addBook(Books book);//增加一个Book
       int deleteBookById(@Param(value = "bookId") int id);//根据id删除一个Book
       int updateBook(Books book);//修改一个Book
       Books queryBookById(@Param(value = "bookId")int id);//根据id查询,返回一个Book
       List<Books> queryAllBook();//查询全部Book,返回list集合
   }
   ```

6. 编写接口对应的Mapper.xml文件：BookMapper.xml。需要导入MyBatis的包

   ```xml
   <?xml version="1.0" encoding="UTF-8" ?>
   <!DOCTYPE mapper
           PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
           "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
   <mapper namespace="com.wangqiang.dao.BookMapper">
       <insert id="addBook" parameterType="Books">
           insert into ssmbuild.books(bookName,bookCounts,detail)
           values (#{bookName},#{bookCounts},#{detail});
       </insert> 
     
       <delete id="deleteBookById" parameterType="int">
           delete from ssmbuild.books where bookID = #{bookId};
       </delete>
     
       <update id="updateBook" parameterType="Books">
           update ssmbuild.books 
           set bookName = #{bookName},bookCounts = #{bookCounts},detail=#{detail}
           where bookID = #{bookId};
       </update>
     
       <select id="queryBookById" resultType="Books">
           select * from ssmbuild.books where bookID = #{bookId};
       </select>
     
       <select id="queryAllBook" resultType="Books">
           select * from ssmbuild.books;
       </select>
   </mapper>
   ```

7. **编写Service层的接口和实现类：**

   BookService接口：

   ```java
   package com.wangqiang.service;
   
   import com.wangqiang.pojo.Books;
   import java.util.List;
   
   public interface BookService {
       int addBook(Books book);
       int deleteBookById( int id);
       int updateBook(Books book);
       Books queryBookById(int id);
       List<Books> queryAllBook();
   }
   ```

   BookServiceImpl实现类：

   ```java
   package com.wangqiang.service;
   
   import com.wangqiang.dao.BookMapper;
   import com.wangqiang.pojo.Books;
   import java.util.List;
   
   public class BookServiceImpl implements BookService {
       //调用dao层的操作，设置一个set接口，方便Spring管理
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
   ```

#### Spring层  

1. 配置**Spring整合MyBatis**，我们这里数据源使用c3p0连接池；

2. 编写Spring整合Mybatis的相关的配置文件：spring-dao.xml

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:context="http://www.springframework.org/schema/context"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
   http://www.springframework.org/schema/beans/spring-beans.xsd
   http://www.springframework.org/schema/context
   https://www.springframework.org/schema/context/spring-context.xsd">
   
   <!--1.关联数据库配置文件-->
       <context:property-placeholder location="classpath:database.properties"></context:property-placeholder>
   
   <!--2.数据库连接池
   				dbcp  半自动化操作  不能自动连接
   				c3p0  自动化操作（自动的加载配置文件 并且设置到对象里面）
       		druid  阿里巴巴出品
        		hikari SpringBoot默认
   -->
       <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
           <property name="driverClass" value="${jdbc.driver}"></property>
           <property name="jdbcUrl" value="${jdbc.url}"></property>
           <property name="user" value="${jdbc.username}"></property>
           <property name="password" value="${jdbc.password}"></property>
           <!-- c3p0连接池的私有属性 -->
           <property name="maxPoolSize" value="30"/>
           <property name="minPoolSize" value="10"/>
           <!-- 关闭连接后不自动commit -->
           <property name="autoCommitOnClose" value="false"/>
           <!-- 获取连接超时时间 -->
           <property name="checkoutTimeout" value="10000"/>
           <!-- 当获取连接失败重试次数 -->
           <property name="acquireRetryAttempts" value="2"/>
       </bean>
   
     <!--3.配置SqlSessionFactory对象-->
       <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
           <!-- 注入数据库连接池 -->
           <property name="dataSource" ref="dataSource"/>
           <!-- 配置MyBaties全局配置文件:mybatis-config.xml -->
           <property name="configLocation" value="classpath:mybatis-config.xml"/>
       </bean>
   
    <!-- 4.配置扫描Dao接口包，动态实现Dao接口注入到spring容器中 -->
       <!--解释 ： https://www.cnblogs.com/jpfss/p/7799806.html-->
       <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
           <!-- 注入sqlSessionFactory -->
           <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"/>
           <!-- 给出需要扫描Dao接口包 -->
           <property name="basePackage" value="com.wangqiang.dao"/>
       </bean>
   </beans>
   ```

3. Spring整合service层

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:context="http://www.springframework.org/schema/context"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context.xsd">
   
       <!--BookServiceImpl注入到IOC容器中-->
       <bean id="BookServiceImpl" class="com.wangqiang.service.BookServiceImpl">
           <property name="bookMapper" ref="bookMapper"/>
       </bean>
       <!-- 扫描service相关的bean -->
       <context:component-scan base-package="com.wangqiang.service"/>
       
       <!-- 配置事务管理器 -->
       <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
           <!-- 注入数据库连接池 -->
           <property name="dataSource" ref="dataSource" />
       </bean>
   </beans>   
   ```

#### SpringMVC层

1. 项目添加框架支持Web，修改WEB-INF文件下web.xml文件

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
            version="4.0">
   
       <!--DispatcherServlet-->
       <servlet>
           <servlet-name>DispatcherServlet</servlet-name>
           <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
           <init-param>
               <param-name>contextConfigLocation</param-name>
               <param-value>classpath:applicationContext.xml</param-value>
           </init-param>
           <load-on-startup>1</load-on-startup>
       </servlet>
       <servlet-mapping>
           <servlet-name>DispatcherServlet</servlet-name>
           <url-pattern>/</url-pattern>
       </servlet-mapping>
       
       <!--encodingFilter-->
       <filter>
           <filter-name>encodingFilter</filter-name>
           <filter-class>
               org.springframework.web.filter.CharacterEncodingFilter
           </filter-class>
           <init-param>
               <param-name>encoding</param-name>
               <param-value>utf-8</param-value>
           </init-param>
       </filter>
       <filter-mapping>
           <filter-name>encodingFilter</filter-name>
           <url-pattern>/*</url-pattern>
       </filter-mapping>
   
       <!--Session过期时间-->
       <session-config>
           <session-timeout>15</session-timeout>
       </session-config>
   </web-app>
   ```

2. spring-mvc.xml

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:context="http://www.springframework.org/schema/context"
          xmlns:mvc="http://www.springframework.org/schema/mvc"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/mvc
       https://www.springframework.org/schema/mvc/spring-mvc.xsd">
   
       <!-- 配置SpringMVC -->
       <!-- 1.开启SpringMVC注解驱动 -->
       <mvc:annotation-driven />
       <!-- 2.静态资源默认servlet配置-->
       <mvc:default-servlet-handler/>
   
       <!-- 3.配置jsp 显示ViewResolver视图解析器 -->
       <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
           <property name="viewClass" value="org.springframework.web.servlet.view.JstlView" />
           <property name="prefix" value="/WEB-INF/jsp/" />
           <property name="suffix" value=".jsp" />
       </bean>
   
       <!-- 4.扫描web相关的bean -->
       <context:component-scan base-package="com.wangqiang.controller" />
   </beans>
   ```

3. Spring配置整合文件：applicationContext.xml

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans.xsd">
   
       <import resource="classpath:spring-dao.xml"></import>
       <import resource="classpath:spring-service.xml"></import>
       <import resource="classpath:spring-mvc.xml"></import>
   </beans>
   ```

   

#### Conntroller 和 视图

1. BookController 类编写 。 方法一：查询全部书籍

   ```java
   package com.wangqiang.controller;
   
   import com.wangqiang.pojo.Books;
   import com.wangqiang.service.BookService;
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.beans.factory.annotation.Qualifier;
   import org.springframework.stereotype.Controller;
   import org.springframework.ui.Model;
   import org.springframework.web.bind.annotation.PathVariable;
   import org.springframework.web.bind.annotation.RequestMapping;
   import java.util.List;
   
   @Controller
   @RequestMapping("/book")
   public class BookController {
   
       @Autowired
       @Qualifier("BookServiceImpl")
       private BookService bookService;
   
     	//查询全部书籍信息
       @RequestMapping("/allBook")
       public String list(Model model){
           List<Books> books = bookService.queryAllBook(curPage, pageSize);
           model.addAttribute("books",books);
           return "allBook";
       }
     
      //添加书籍信息
       @RequestMapping("/toAddBook")
       public String toAddPaper() {
           return "addBook";
       }
       @RequestMapping("/addBook")
       public String addPaper(Books books) {
           System.out.println(books);
           bookService.addBook(books);
           return "redirect:/book/allBook";
       }
   
      //修改书籍信息
       @RequestMapping("/toUpdateBook")
       public String toUpdateBook(Model model, int id) {
           Books books = bookService.queryBookById(id);
           System.out.println(books);
           model.addAttribute("book",books );
           return "updateBook";
       }
       @RequestMapping("/updateBook")
       public String updateBook(Model model, Books book) {
           System.out.println(book);
           bookService.updateBook(book);
           Books books = bookService.queryBookById(book.getBookId());
           model.addAttribute("books", books);
           return "redirect:/book/allBook";
       }
   
     //删除书籍信息
       @RequestMapping("/del/{bookId}")
       public String deleteBook(@PathVariable("bookId") int id) {
           bookService.deleteBookById(id);
           return "redirect:/book/allBook";
       }
   }
   ```

2. 编写首页：index.jsp 

   ```html
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
     <head>
       <title>$Title$</title>
       <style type="text/css">
         a {
           text-decoration: none;
           color: black;
           font-size: 18px;
         }
         h3 {
           width: 180px;
           height: 38px;
           margin: 100px auto;
           text-align: center;
           line-height: 38px;
           background: deepskyblue;
           border-radius: 4px;
         }
       </style>
     </head>
     <body>
     <h3>
       <a href="${pageContext.request.contextPath}/book/allBook">点击进入列表页</a>
     </h3>
     </body>
   </html>
   ```

3. 编写书籍列表页：allBook.jsp

   ```html
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
   <head>
       <title>书籍列表</title>
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <!-- 引入 Bootstrap -->
       <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
   </head>
   <body>
   
   <div class="container">
       <div class="row clearfix">
           <div class="col-md-12 column">
               <div class="page-header">
                   <h1>
                       <small>书籍列表 —— 显示所有书籍</small>
                   </h1>
               </div>
           </div>
       </div>
   
       <div class="row">
           <div class="col-md-4 column">
               <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toAddBook">新增</a>
           </div>
       </div>
   
       <div class="row clearfix">
           <div class="col-md-12 column">
               <table class="table table-hover table-striped">
                   <thead>
                   <tr>
                       <th>书籍编号</th>
                       <th>书籍名字</th>
                       <th>书籍数量</th>
                       <th>书籍详情</th>
                       <th>操作</th>
                   </tr>
                   </thead>
                   <tbody>
                   <c:forEach var="book" items="${requestScope.get('books')}">
                       <tr>
                           <td>${book.getBookId()}</td>
                           <td>${book.getBookName()}</td>
                           <td>${book.getBookCounts()}</td>
                           <td>${book.getDetail()}</td>
                           <td>
                               <a href="${pageContext.request.contextPath}/book/toUpdateBook?id=${book.getBookId()}">更改</a> |
                               <a href="${pageContext.request.contextPath}/book/del/${book.getBookId()}">删除</a>
                           </td>
                       </tr>
                   </c:forEach>
                   </tbody>
   
               </table>
           </div>
       </div>
     
   </div>
   ```

4. 编写添加书籍页面：addBook.jsp

   ```html
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   
   <html>
   <head>
       <title>新增书籍</title>
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <!-- 引入 Bootstrap -->
       <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
   </head>
   <body>
   <div class="container">
   
       <div class="row clearfix">
           <div class="col-md-12 column">
               <div class="page-header">
                   <h1>
                       <small>新增书籍</small>
                   </h1>
               </div>
           </div>
       </div>
       <form action="${pageContext.request.contextPath}/book/addBook" method="post">
           书籍名称：<input type="text" name="bookName"><br><br><br>
           书籍数量：<input type="text" name="bookCounts"><br><br><br>
           书籍详情：<input type="text" name="detail"><br><br><br>
           <input type="submit" value="添加">
       </form>
   
   </div>
   </body>
   </html>
   ```

5. 编写修改书籍页面：updateBook.jsp

   ```html
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
   <head>
       <title>修改信息</title>
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <!-- 引入 Bootstrap -->
       <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
   </head>
   <body>
   <div class="container">
   
       <div class="row clearfix">
           <div class="col-md-12 column">
               <div class="page-header">
                   <h1>
                       <small>修改信息</small>
                   </h1>
               </div>
           </div>
       </div>
   
       <form action="${pageContext.request.contextPath}/book/updateBook" method="post">
           <input type="hidden" name="bookId" value="${book.getBookId()}"/>
           书籍名称：<input type="text" name="bookName" value="${book.getBookName()}"/>
           书籍数量：<input type="text" name="bookCounts" value="${book.getBookCounts()}"/>
           书籍详情：<input type="text" name="detail" value="${book.getDetail() }"/>
           <input type="submit" value="提交"/>
       </form>
   
   </div>
   </body>
   </html>
   ```
## 参考资料
[狂神说Java](https://www.bilibili.com/video/av71874024?p=1)   
后期自己完善了分页和模糊查询功能。

   

