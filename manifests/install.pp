class td_agent::install {
    file {'td':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        path    => '/etc/yum.repos.d/td.repo',
        source  => 'puppet:///modules/td_agent/td.repo',
    }
    package {"td-agent":
        ensure  => present,
        require => file["td"],
    }

   # file {"td-libyaml":
   #     ensure => present,
   #     owner => 'root',
   #     group => 'root',
   #     mode => '0644',
   #     path => '/tmp/td-libyaml-0.1.4-1.x86_64.rpm',
   #     source => 'puppet:///modules/td_agent/td-libyaml-0.1.4-1.x86_64.rpm',                                              
   # }
  
   # package {"td-libyaml":
   #     ensure  => present,
   #     provider => rpm,
   #     source   => "/tmp/td-libyaml-0.1.4-1.x86_64.rpm",
   #     require => File["td-libyaml"],
   # }

   # file {"td-agent":
   #     ensure => present,
   #     owner => 'root',
   #     group => 'root',
   #     mode => '0644',
   #     path => '/tmp/td-agent-1.1.19-0.x86_64.rpm',
   #     source => 'puppet:///modules/td_agent/td-agent-1.1.19-0.x86_64.rpm',
   #     require => Package["td-libyaml"],                                              
   # }
  
   # package {"td-agent":
   #     ensure  => present,
   #     provider => rpm,
   #     source   => "/tmp/td-agent-1.1.19-0.x86_64.rpm",
   #     require => File["td-agent"],
   # }

    file {'td-agent':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        path    => '/etc/init.d/td-agent',
        source  => 'puppet:///modules/td_agent/td-agent',
        require => Package["td-agent"],
    }

    file {'config':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        path    => '/etc/td-agent/config.d',
    }

}

