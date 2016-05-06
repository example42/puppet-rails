class rails::install::gem (

  Variant[Boolean,String]  $ensure             = present,

  Boolean                  $auto_prerequisites = true,

) {

  include ::rails

  $preinstall = $auto_prerequisites ? {
    true  => $::rails::module_settings['package_dependencies'],
    false => false,
  }

  if $preinstall {
    $preinstall.each |$pkg| {
      ensure_packages($pkg)
    }
  }

  $default_settings = {
    'package_provider' => 'gem',
  }

  ::tp::install { 'rails':
    ensure           => $ensure,
    settings_hash    => $::rails::module_settings + $default_settings,
    data_module      => $::rails::data_module,
    auto_conf        => false,
  }

}
