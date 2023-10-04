<?php

global $class_types;

$array_systypes = array();

$shortcuts_type  = array();

$actions_print = array();

$types_item = array(
    '采购计划配置项' => array(
        'name' => 'qms.steup',
        'data' => array(
            '默认截止时间' => array('type' => 'varchar', 'length' => 10, 'default' => '23:00'),
            '文件大小限制' => array('type' => 'varchar', 'length' => 10, 'default' => '2MB'),
            '标题前缀' => array('type' => 'varchar', 'length' => 20, 'default' => '采购计划_'),
            '显示历史报价' => array('type' => 'int', 'length' => 0, 'default' => 1)
        )
    )
);

$class_types = array();

$types_search = array();
