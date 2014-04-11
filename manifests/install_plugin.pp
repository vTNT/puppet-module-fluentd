define td_agent::install_plugin (
    $ensure = 'present',
    $provider = 'fluentgem',
    $plugin_name = $name,
){
    package {$plugin_name:
        ensure   => 'installed',
        provider => $provider,
        require  => Package['td-agent'],
    } 
}
