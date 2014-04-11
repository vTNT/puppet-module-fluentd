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
    file {'td-agent':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        path    => '/etc/init.d/td-agent',
        source  => 'puppet:///modules/td_agent/td-agent',
    }

    file {'config':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        path    => '/etc/td-agent/config.d',
    }

}

