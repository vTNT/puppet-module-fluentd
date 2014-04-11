# == definition fluentd::source
define td_agent::source (
    $configfile,
    $type,
    $tag = false,
    $format = false,
    $config = {},
) {

    concat::fragment { "source_${title}":
        target => "/etc/td-agent/config.d/${configfile}.conf",
        require => Package['td-agent'],
        content => template('td_agent/source.erb'),
    }
}
