node default {
  $packages=hiera(packages,[])
  package { $packages:
    ensure => installed,
    notify => Exec['yum_clean_all']
  }

  exec {'yum_clean_all':
    command     => '/usr/bin/yum clean all',
    refreshonly => true,
  }
  file {'/etc/supervisord.d/':
    source  => 'file:////puppet/files/supervisor.d/',
    recurse => true,
    require => Package['supervisor']
  }

  #Cobbler settings
}
