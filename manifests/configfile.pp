# == definition fluentd::configfile
define td_agent::configfile {

    $source_conf = "/etc/td-agent/config.d/${title}.conf"
    
  #  exec {"reload_td_agent":
  #      refreshonly => true,
  #      command => "/etc/init.d/td-agent restart",
  #  }

    concat{$source_conf:
        owner => 'root',
        group => 'root',
        mode => '0644',
        require => Package['td-agent'],
  #      notify => Exec["reload_td_agent"],
    }
}


