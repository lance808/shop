-- ============================================
-- 商城管理系统 - 扩展功能数据库脚本
-- 商品评价 + 收货地址 + 收藏夹
-- ============================================

USE shop_db;

-- ========== 商品评价表 ==========
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `order_id` INT,
    `rating` TINYINT NOT NULL DEFAULT 5 COMMENT '1-5星评分',
    `content` TEXT COMMENT '评价内容',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_product (`product_id`),
    INDEX idx_user (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价表';

-- ========== 收货地址表 ==========
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `receiver_name` VARCHAR(50) NOT NULL,
    `receiver_phone` VARCHAR(20) NOT NULL,
    `province` VARCHAR(50) DEFAULT '',
    `city` VARCHAR(50) DEFAULT '',
    `district` VARCHAR(50) DEFAULT '',
    `detail` VARCHAR(200) NOT NULL COMMENT '详细地址',
    `is_default` TINYINT DEFAULT 0 COMMENT '1-默认地址',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';

-- ========== 收藏夹表 ==========
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_product (`user_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收藏夹表';

-- ========== 示例数据 ==========

-- 评价示例
INSERT INTO `review` (`user_id`, `product_id`, `rating`, `content`) VALUES
(2, 1, 5, '非常好用，运行速度快，拍照效果惊艳！'),
(2, 2, 4, '支持国产，信号确实好，系统流畅'),
(3, 1, 5, '送给老婆的礼物，她很喜欢'),
(3, 9, 4, '坚果很新鲜，包装精美，物流快'),
(2, 10, 3, '价格实惠，整箱买很划算');

-- 地址示例
INSERT INTO `address` (`user_id`, `receiver_name`, `receiver_phone`, `province`, `city`, `district`, `detail`, `is_default`) VALUES
(2, '张三', '13900000001', '广东省', '广州市', '天河区', '天河路100号创新大厦15楼', 1),
(2, '张三', '13900000001', '湖南省', '长沙市', '岳麓区', '麓谷科技园B座3层', 0),
(3, '李四', '13900000002', '北京市', '北京市', '朝阳区', '望京SOHO T1-2001', 1);

-- 收藏示例
INSERT INTO `favorite` (`user_id`, `product_id`) VALUES
(2, 3),
(2, 5),
(2, 7),
(3, 1),
(3, 6);
