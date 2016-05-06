class rails::install::package (

  Variant[Boolean,String]  $ensure             = present,

) {

  include ::rails

  ::tp::install { 'rails':
    ensure           => $ensure,
    settings_hash    => $::rails::module_settings,
    data_module      => $::rails::data_module,
    auto_conf        => false,
  }

}
