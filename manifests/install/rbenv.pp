# Note: This class requires module jdowning/rbenv
#
class rails::install::rbenv (

  Variant[Boolean,String]  $ensure             = present,

  Boolean                  $auto_prerequisites = true,

) {

  include ::rails
  include ::rbenv

  $preinstall = $auto_prerequisites ? {
    true  => $::rails::module_settings['package_dependencies'],
    false => false,
  }

  if $preinstall {
    $preinstall.each |$pkg| {
      ensure_packages($pkg)
    }
  }

}
