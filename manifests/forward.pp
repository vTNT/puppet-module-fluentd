# == definition fluentd::match
define td_agent::forward (
    $configfile,
    $type,
    $servers = [],
) {

    concat::fragment { "match_${title}":
        target => "/etc/td-agent/config.d/${configfile}.conf",
        require => Package['td-agent'],
        content => template('td_agent/forward.erb'),
    }
}
