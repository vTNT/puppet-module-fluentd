# == definition fluentd::match
define td_agent::es (
    $configfile,
    $pattern,
    $type_name,
    $servers = [],
) {

    concat::fragment { "match_${title}":
        target => "/etc/td-agent/config.d/${configfile}.conf",
        require => Package['td-agent'],
        content => template('td_agent/es.erb'),
    }
}
