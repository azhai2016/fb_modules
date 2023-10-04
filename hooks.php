<?php
/*=======================================================\
|          返利折让系统                                    |
|--------------------------------------------------------|
|   Creator: azhai <1229991003@qq.com>          |
|   Date :   03-01-2023                                 |
|   Description: Frontaccounting Payroll & Mpms Module    |
|   Free software under GNU GPL                          |
|                                                        |
\=======================================================*/

// define('SS_QMS', 50 << 8);

class hooks_qms extends hooks
{
	function __construct()
	{
		//$this->module_name = 'qms';
	}

	function install_tabs($app)
	{
		//$app->add_application(new QmsApp);
	}

	function install_access()
	{

		global $systypes_array;

		$sales = QmsApp::install_access();
		$security_sections = $sales[0];
		$security_areas = $sales[1];

		return array($security_areas, $security_sections, $systypes_array);
	}

	function activate_extension($company, $check_only = true)
	{
		global $db_connections;

		$updates = []; // eg. array('update.sql' => array('qms'));

		return $this->update_databases($company, $updates, $check_only);
	}

	function deactivate_extension($company, $check_only = true)
	{
		global $db_connections;

		$updates =[]; //eg. array('remove.sql' => array('qms'));

		return $this->update_databases($company, $updates, $check_only);
	}
}
