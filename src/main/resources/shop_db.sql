-- ============================================
-- 商城商品管理系统 - 数据库脚本
-- ============================================

DROP DATABASE IF EXISTS shop_db;
CREATE DATABASE shop_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE shop_db;

-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL,
    `real_name` VARCHAR(50),
    `phone` VARCHAR(20),
    `email` VARCHAR(100),
    `role` VARCHAR(20) NOT NULL DEFAULT 'user' COMMENT 'admin-管理员, user-普通用户',
    `status` TINYINT DEFAULT 1 COMMENT '1-正常, 0-禁用',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 商品分类表
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `parent_id` INT DEFAULT 0,
    `sort_order` INT DEFAULT 0,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 商品表
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `description` TEXT,
    `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `stock` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(500),
    `category_id` INT,
    `status` TINYINT DEFAULT 1 COMMENT '1-上架, 0-下架',
    `sales` INT DEFAULT 0 COMMENT '销量',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (`category_id`),
    INDEX idx_name (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 购物车表
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `quantity` INT NOT NULL DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_product (`user_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 订单表
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_no` VARCHAR(50) NOT NULL UNIQUE,
    `user_id` INT NOT NULL,
    `total_price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `status` VARCHAR(20) NOT NULL DEFAULT 'pending' COMMENT 'pending-待支付, paid-已支付, shipped-已发货, completed-已完成, cancelled-已取消',
    `receiver_name` VARCHAR(50),
    `receiver_phone` VARCHAR(20),
    `receiver_address` VARCHAR(500),
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `pay_time` DATETIME,
    INDEX idx_user (`user_id`),
    INDEX idx_order_no (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单明细表
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `product_name` VARCHAR(200),
    `product_price` DECIMAL(10,2),
    `quantity` INT NOT NULL DEFAULT 1,
    `total_price` DECIMAL(10,2),
    INDEX idx_order (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- ========== 初始数据 ==========

-- 管理员账号: admin / admin123
INSERT INTO `user` (`username`, `password`, `real_name`, `phone`, `email`, `role`) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '13800000000', 'admin@shop.com', 'admin'),
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', '13900000001', 'zhangsan@qq.com', 'user'),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', '13900000002', 'lisi@qq.com', 'user');

-- 分类数据
INSERT INTO `category` (`name`, `parent_id`, `sort_order`) VALUES
('电子产品', 0, 1),
('服装鞋帽', 0, 2),
('食品饮料', 0, 3),
('家居生活', 0, 4),
('手机', 1, 1),
('电脑', 1, 2),
('耳机', 1, 3),
('男装', 2, 1),
('女装', 2, 2),
('休闲零食', 3, 1),
('饮料', 3, 2);

-- 商品数据
INSERT INTO `product` (`name`, `description`, `price`, `stock`, `category_id`, `sales`) VALUES
('iPhone 15 Pro Max', '最新款苹果手机，搭载A17芯片', 9999.00, 50, 5, 120),
('华为 Mate 60 Pro', '国产旗舰手机，卫星通信', 6999.00, 100, 5, 85),
('MacBook Pro 16英寸', 'M3 Pro芯片，专业设计利器', 14999.00, 30, 6, 45),
('联想 ThinkPad X1', '商务办公笔记本', 8999.00, 40, 6, 32),
('AirPods Pro 2', '主动降噪蓝牙耳机', 1899.00, 200, 7, 300),
('Sony WH-1000XM5', '头戴式降噪耳机', 2499.00, 80, 7, 65),
('男士纯棉T恤', '舒适透气，多色可选', 79.90, 500, 8, 220),
('女士连衣裙', '夏季新款，时尚优雅', 299.00, 300, 9, 150),
('三只松鼠坚果礼盒', '每日坚果，健康零食', 128.00, 400, 10, 500),
('可口可乐 330ml*24', '经典汽水，整箱装', 59.90, 1000, 11, 800);
