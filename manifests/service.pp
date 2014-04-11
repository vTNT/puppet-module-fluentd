class td_agent::service {
      file {"td-agent.conf":
        mode    => 644,
        owner   => root,
        group   => root,
        path    => "/etc/td-agent/td-agent.conf",
        content => template('td_agent/td-agent.erb'),
        require => Class["td_agent::install"],
        notify  => Service['td-agent']
      }

      service { "td-agent":
        ensure  => running,
        enable  => true,
        subscribe => File['td-agent.conf']
      }
   }
