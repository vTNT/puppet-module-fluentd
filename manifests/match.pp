# == definition fluentd::match
define td_agent::match (
    $configfile,
    $type,
    $pattern,
    $config = {},
    $servers = [],
) {

    concat::fragment { "match_${title}":
        target => "/etc/td-agent/config.d/${configfile}.conf",
        require => Package['td-agent'],
        content => template('td_agent/match.erb'),
    }
}
