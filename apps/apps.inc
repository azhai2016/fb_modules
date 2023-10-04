<?php

class QmsApp extends application
{
    public function __construct()
    {

        global $path_to_root;

        $url =  $path_to_root . '/modules/qms';

        parent::__construct('qms', _($this->help_context = '采购报价(&P)'));

        $this->add_module(_('计划管理'));
        $this->add_lapp_function(0, _('商品采购询价'), $url . '/apps/create.php?NewOrder=Yes', 'SA_QMS_CREATE', MENU_BPGL);
        $this->add_lapp_function(0, _('商品采购审核'), $url . '/apps/examine.php?NewOrder=Yes', 'SA_QMS_EXAMINE', MENU_BPGL);
        $this->add_lapp_function(0, '', '');

        $this->add_extensions();
    }


    public static function install_access()
    {

        $security_sections[SS_QMS] =  _('采购报价');

        $security_areas['SA_QMS_CREATE'] = array(SS_QMS | 1, _('采购计划录入'));
        $security_areas['SA_QMS_EXAMINE'] = array(SS_QMS | 1, _('采购计划审核'));
        $security_areas['SA_QMS_LIST'] = array(SS_QMS | 1, _('采购计划记录'));


        return array($security_sections, $security_areas);
    }
}
