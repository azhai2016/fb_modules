-- 客户设置列表 -------------------------
SET NAMES utf8;
DROP TABLE IF EXISTS `0_plan_suppliers`;
-- 创建供应商信息表,先写入users表，得到user表 id 写入user_id
CREATE TABLE `0_plan_suppliers` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id SMALLINT NOT NULL,
  company_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  contact_person VARCHAR(255) NOT NULL,
  contact_phone VARCHAR(255) NOT NULL,
  qualification VARCHAR(255) NULL,
  first_choice SMALLINT NOT NULL DEFAULT 0,
  status ENUM('待审核', '通过', '未通过') NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES 0_users(id)
);
INSERT INTO `0_security_roles`
VALUES (
    null,
    '采购员报价权限',
    '采购员报价权限',
    '746496',
    '746600;746601',
    '0'
  );
DROP TABLE IF EXISTS `0_plan_goods`;
-- 创建报价商品表
CREATE TABLE `0_plan_goods` (
  goods_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT '商品编号',
  goods VARCHAR(255) NOT NULL COMMENT '商品名称',
  factory VARCHAR(255) NOT NULL COMMENT '生产企业',
  spec VARCHAR(255) NOT NULL COMMENT '规格',
  units VARCHAR(20) NOT NULL COMMENT '单位',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DROP TABLE IF EXISTS `0_plan_tenders`;
-- 创建招标公告表
CREATE TABLE `0_plan_tenders` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME NOT NULL,
  attachment VARCHAR(255),
  status ENUM('待审核', '通过', '未通过', '结束') NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DROP TABLE IF EXISTS `0_plan_tenders_goods`;
-- 创建报价商品表
CREATE TABLE `0_plan_tenders_goods` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tender_id INT NOT NULL,
  goods_id VARCHAR(255) NOT NULL COMMENT '商品编号',
  goods VARCHAR(255) NOT NULL COMMENT '商品名称',
  factory VARCHAR(255) NOT NULL COMMENT '生产企业',
  spec VARCHAR(255) NOT NULL COMMENT '规格',
  units VARCHAR(20) NOT NULL COMMENT '单位',
  approve_no VARCHAR(100) NULL COMMENT '批准文号',
  qty int NOT NULL DEFAULT 0 COMMENT '数量',
  barcode varchar(20) NULL COMMENT '条形码',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DROP TABLE IF EXISTS `0_plan_excel_template`;
-- 导入excel模版表
CREATE TABLE `0_plan_excel_template` (
  user_id varchar(30) NULL COMMENT '用户ID',
  source_key VARCHAR(20) NOT NULL COMMENT '源标题',
  target_field VARCHAR(100) NOT NULL COMMENT '目标字段',
  comment VARCHAR(30) NOT NULL COMMENT '说明',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, source_key),
  UNIQUE KEY (user_id, source_key)
);
DROP TABLE IF EXISTS `0_plan_codes`;
-- 商品信息对码表
CREATE TABLE `0_plan_codes` (
  user_id varchar(30) NULL COMMENT '用户ID',
  goods_id VARCHAR(20) NOT NULL COMMENT '商品编号',
  api_id VARCHAR(20) NOT NULL COMMENT '商家编号',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, goods_id, api_id),
  UNIQUE KEY (goods_id, user_id, api_id)
);
DROP TABLE IF EXISTS `0_plan_tendered_master`;
-- 报价主表单
CREATE TABLE `0_plan_tendered_master` (
  tender_id INT NOT NULL,
  user_id varchar(30) NULL COMMENT '用户ID',
  goods_id VARCHAR(255) NOT NULL COMMENT '商品编号',
  min_price decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '单价',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (tender_id, goods_id),
  UNIQUE KEY (goods_id, tender_id)
);
DROP TABLE IF EXISTS `0_plan_tendered_detail`;
-- 报价列单
CREATE TABLE `0_plan_tendered_detail` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tender_id INT NOT NULL,
  user_id varchar(30) NOT NULL COMMENT '用户ID',
  goods_id VARCHAR(255) NOT NULL COMMENT '商品编号',
  price decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '单价',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DROP TABLE IF EXISTS `0_plan_quotes`;
-- 创建报价表
CREATE TABLE `0_plan_quotes` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tender_id INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  description TEXT NOT NULL,
  attachment VARCHAR(255),
  status ENUM('待审核', '通过', '未通过') NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tender_id) REFERENCES 0_plan_tenders(id)
);
DROP TABLE IF EXISTS `0_evaluation_results`;
-- 创建评标结果表
CREATE TABLE `0_evaluation_results` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tender_id INT NOT NULL,
  supplier_id INT NOT NULL,
  score DECIMAL(5, 2) NOT NULL,
  rank INT NOT NULL,
  status ENUM('中标', '未中标') NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tender_id) REFERENCES 0_plan_tenders(id),
  FOREIGN KEY (supplier_id) REFERENCES 0_plan_suppliers(id)
);
--
DROP TABLE IF EXISTS `0_plan_contracts`;
-- 创建合同表
CREATE TABLE `0_plan_contracts` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tender_id INT NOT NULL,
  supplier_id INT NOT NULL,
  contract_no VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  status ENUM('待签订', '已签订', '已生效', '已终止') NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tender_id) REFERENCES 0_plan_tenders(id),
  FOREIGN KEY (supplier_id) REFERENCES 0_plan_suppliers(id)
);
INSERT INTO `0_sys_prefs`
VALUES (
    '默认开始时间',
    'qms.def_start_time',
    'varchar',
    15,
    '09:00'
  ),
  (
    '默认截止时间',
    'qms.def_end_time',
    'varchar',
    15,
    '23:00'
  );