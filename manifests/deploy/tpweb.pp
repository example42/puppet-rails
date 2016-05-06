class rails::deploy::tpweb (
  Variant[Boolean,String]  $ensure              = present,
  Hash                     $options             = { },
  Variant[Undef,String[1]] $config_template     = undef,
 
  String                   $destination_path    = '/opt/tpweb',
  String                   $git_url             = 'https://github.com/example42/tp-web',

  String                   $user                = 'tpweb',
  Boolean                  $user_create         = true,
) {

  if $user_create {
    user { $user:
      ensure => $ensure,
    }
  }

  $exec_user = $user_create ? {
    true  => $user,
    false => 'root',
  }
  tp_install('git')

  tp::dir { 'rails::tpweb':
    path    => $destination_path,
    vcsrepo => git,
    source  => $git_url,
    require => Tp::Install['git'],
    notify  => Exec['tpweb setup'],
  }
  exec { 'tpweb setup':
    command => "${destination_path}/bin/setup",
    user    => $exex_user,
    cwd     => $destination_path,
  }

}
