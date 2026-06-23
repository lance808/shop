# shop - 商城管理系统

基于 **SSM（Spring + Spring MVC + MyBatis）** 框架的在线商城管理系统，具备前台商城和后台管理两大模块。

---

## 技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| Spring | 5.2.22 | IoC 容器、事务管理 |
| Spring MVC | 5.2.22 | Web 层 MVC 框架 |
| MyBatis | 3.5.11 | ORM 持久层框架 |
| MyBatis-Spring | 2.0.7 | MyBatis 与 Spring 整合 |
| Druid | 1.2.16 | 数据库连接池 |
| MySQL | 8.0 | 关系型数据库 |
| JSP + JSTL | 2.3.1 / 1.2 | 视图模板 |
| Logback | 1.2.12 | 日志框架 |
| Jackson | 2.13.5 | JSON 序列化 |
| JDK | 1.8 | Java 运行环境 |
| Tomcat | 9.x | Web 容器 |

---

## 项目结构

```
shop/
├── pom.xml
└── src/main/
    ├── java/com/shop/
    │   ├── controller/         # 控制器（8个）
    │   │   ├── ProductController    # 商品浏览、搜索
    │   │   ├── UserController       # 登录注册、个人中心
    │   │   ├── CartController       # 购物车
    │   │   ├── OrderController      # 订单流程
    │   │   ├── AdminController      # 后台管理 + 数据统计
    │   │   ├── AddressController    # 收货地址
    │   │   ├── FavoriteController   # 收藏夹
    │   │   └── ReviewController     # 商品评价
    │   ├── dao/                # 数据访问层（9个）
    │   ├── entity/             # 实体类（9个）
    │   ├── interceptor/        # 拦截器
    │   │   ├── LoginInterceptor    # 登录拦截
    │   │   └── AdminInterceptor    # 管理员权限拦截
    │   ├── service/            # 业务逻辑层（8个接口 + 8个实现）
    │   └── util/               # 工具类
    │       ├── PasswordUtil    # MD5 密码加密
    │       └── OrderNoUtil     # 订单号生成
    ├── resources/
    │   ├── mapper/             # MyBatis Mapper XML（9个）
    │   ├── spring-mvc.xml      # Spring MVC 配置
    │   ├── spring-mybatis.xml  # Spring + MyBatis 整合配置
    │   ├── mybatis-config.xml  # MyBatis 全局配置
    │   ├── jdbc.properties     # 数据库连接配置
    │   ├── logback.xml         # 日志配置
    │   ├── shop_db.sql         # 数据库建表 + 基础数据
    │   ├── shop_db_extra_data.sql   # 扩展商品数据（220个）
    │   └── shop_db_extended.sql     # 评价/地址/收藏表 + 示例数据
    └── webapp/
        ├── css/
        │   ├── style.css       # 前台样式
        │   └── admin.css       # 后台样式
        └── WEB-INF/
            ├── web.xml         # Web 部署描述符
            └── views/          # JSP 视图
                ├── header.jsp / footer.jsp   # 公共头部/底部
                ├── index.jsp                 # 首页
                ├── login.jsp / register.jsp  # 登录/注册
                ├── product_list.jsp          # 商品列表
                ├── product_detail.jsp        # 商品详情 + 评价
                ├── cart_list.jsp             # 购物车
                ├── order_confirm.jsp         # 订单确认
                ├── order_list.jsp            # 订单列表
                ├── order_detail.jsp          # 订单详情
                ├── profile.jsp               # 个人中心
                ├── address_list.jsp          # 收货地址
                ├── address_form.jsp          # 地址编辑
                ├── favorite_list.jsp         # 收藏夹
                ├── review_list.jsp           # 评价列表
                ├── pagination.jsp            # 分页组件
                └── admin/                    # 后台视图
                    ├── index.jsp             # 控制台
                    ├── stats.jsp             # 数据统计
                    ├── product_list.jsp      # 商品管理
                    ├── product_form.jsp      # 商品编辑
                    ├── category_list.jsp     # 分类管理
                    ├── category_form.jsp     # 分类编辑
                    ├── order_list.jsp        # 订单管理
                    └── order_detail.jsp      # 订单详情
```

---

## 功能模块

### 前台商城

| 模块 | 功能 | 路径 |
|------|------|------|
| 用户中心 | 注册、登录、退出、修改资料 | `/user/**` |
| 商品浏览 | 首页、分类筛选、5×5 网格 + 分页、搜索、详情 | `/` `/product/**` |
| 购物车 | 添加、修改数量、删除 | `/cart/**` |
| 订单流程 | 确认下单、创建订单、列表、详情、取消、支付 | `/order/**` |
| 商品评价 | 发表评价（1-5星 + 文字）、查看评价列表 | `/review/**` |
| 收藏夹 | 收藏/取消收藏、收藏列表 | `/favorite/**` |
| 收货地址 | 多地址管理、设为默认 | `/address/**` |

### 后台管理

| 模块 | 功能 | 路径 |
|------|------|------|
| 控制台 | 概览统计 | `/admin/index` |
| 数据统计 | 订单状态分布、销售额、热销 TOP10、商品库存 | `/admin/stats` |
| 商品管理 | 增删改查、上/下架、图片上传 | `/admin/product/**` |
| 分类管理 | 增删改、父子分类层级 | `/admin/category/**` |
| 订单管理 | 列表、详情、发货、完成 | `/admin/order/**` |

---

## 数据库

### 表结构（9 张表）

| 表名 | 说明 |
|------|------|
| `user` | 用户表（admin/普通用户） |
| `category` | 商品分类（父子层级） |
| `product` | 商品表（名称/价格/库存/销量/状态） |
| `cart` | 购物车 |
| `order` | 订单表 |
| `order_item` | 订单明细 |
| `review` | 商品评价（星级+内容） |
| `address` | 收货地址（多地址+默认） |
| `favorite` | 收藏夹 |

### 初始化脚本

按顺序执行：
```sql
source src/main/resources/shop_db.sql           -- 基础库表 + 10个商品
source src/main/resources/shop_db_extra_data.sql -- 补充210个商品（共220个）
source src/main/resources/shop_db_extended.sql   -- 评价/地址/收藏表 + 示例数据
```

### 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 普通用户 | zhangsan | 123456 |
| 普通用户 | lisi | 123456 |

### 数据库配置

修改 [`jdbc.properties`](src/main/resources/jdbc.properties)：
```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/shop_db?useUnicode=true&characterEncoding=utf-8
jdbc.username=root
jdbc.password=123456
```

---

## 运行

### 前置条件

- JDK 1.8+
- MySQL 8.0+
- Tomcat 9.x
- Maven 3.x

### 步骤

1. **导入数据库**
   ```bash
   mysql -u root -p < src/main/resources/shop_db.sql
   mysql -u root -p < src/main/resources/shop_db_extra_data.sql
   mysql -u root -p < src/main/resources/shop_db_extended.sql
   ```

2. **修改数据库连接**（如需要）
   编辑 `src/main/resources/jdbc.properties`

3. **编译打包**
   ```bash
   mvn clean package -DskipTests
   ```

4. **部署到 Tomcat**
   将 `target/shop.war` 复制到 Tomcat 的 `webapps/` 目录，启动 Tomcat

5. **IDEA 部署**
   - Run → Edit Configurations → 添加 Tomcat Server → Local
   - Deployment → 添加 `shop:war exploded`
   - Application Context 设为 `/shop-manager`
   - 启动后访问 `http://localhost:8080/shop-manager/`

---

## 架构说明

```
请求 → DispatcherServlet → HandlerMapping
                                  ↓
                             Controller（处理请求）
                                  ↓
                           Service（业务逻辑）
                                  ↓
                            DAO / Mapper（数据访问）
                                  ↓
                              MySQL 数据库
                                  ↓
                            返回 ModelAndView
                                  ↓
                         ViewResolver → JSP 渲染
```

- **Web 层**：Spring MVC `DispatcherServlet` 拦截 `/` 请求
- **IoC 容器**：`spring-mybatis.xml` 管理 Service、DAO、数据源、事务
- **拦截器**：`LoginInterceptor` 拦截需要登录的路径，`AdminInterceptor` 检查管理员权限
- **事务**：`@Transactional` 注解保证订单创建等操作的原子性
- **静态资源**：`<mvc:default-servlet-handler/>` 交由 Tomcat 默认 Servlet 处理

---

## 配置文件说明

| 文件 | 说明 |
|------|------|
| `web.xml` | 字符编码过滤器、Spring 监听器、DispatcherServlet |
| `spring-mvc.xml` | 组件扫描、注解驱动、拦截器、视图解析器、文件上传 |
| `spring-mybatis.xml` | 数据源配置、SqlSessionFactory、Mapper 扫描、事务管理 |
| `mybatis-config.xml` | 驼峰映射、缓存、延迟加载、别名扫描 |
| `logback.xml` | 控制台 + 文件日志，`com.shop` 包 DEBUG 级别 |
