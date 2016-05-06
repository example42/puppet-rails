class rails (

  String    $install_class    = '::rails::profile::gem',
  String    $webserver_class  = '',
  String    $config_class     = '',
  String    $deploy_class     = '',

  Hash      $options          = { },
  Hash      $settings         = { },

  Boolean   $auto_restart     = true,
  Boolean   $auto_conf        = false,

  String[1] $data_module      = 'rails',

) {

  $tp_settings = tp_lookup('rails','settings',$data_module,'merge')
  $module_settings = $tp_settings + $settings
  if $module_settings['service_name'] and $auto_restart {
    $service_notify = "Service[${module_settings['service_name']}]"
  } else {
    $service_notify = undef
  }

  if $install_class != '' {
    include $install_class
  }
  if $webserver_class != '' {
    include $webserver_class
  }
  if $config_class != '' {
    include $config_class
  }
  if $deploy_class != '' {
    include $deploy_class
  }


}
