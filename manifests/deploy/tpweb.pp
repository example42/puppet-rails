class rails::deploy::tpweb (
  Variant[Boolean,String]  $ensure              = present,
  Hash                     $options             = { },
  Variant[Undef,String[1]] $config_template     = undef,
 
  String                   $destination_path    = '/opt/tpweb',
  String                   $git_url             =
  'https://github.com/example42/tp-web',
  String                   $git_branch          = '',

) {

  tp_install('git')

  tp::dir { 'rails::tpweb':
    path    => $destination_path,
    vcsrepo => git,
    source  => $git_url,
    require => Tp::Install['git'],
  }
}
