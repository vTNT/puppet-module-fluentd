import "modules.pp"

node "net-180" {
#    include fluentd
    include "td_agent"
    include concat::setup

    td_agent::configfile { 'syslog': }
    td_agent::source { 'syslog_main': 
        configfile => 'syslog',
        type => 'tail',
        format => 'syslog',
        tag => 'system.syslog',
        config => {
            'path' => '/var/log/messages',
            'pos_file' => '/var/log/td-agent/td-agent.syslog.pos',
        }
    }

    td_agent::configfile { 'apache': }
    td_agent::source { 'apache_main': 
        configfile => 'apache',
        type => 'tail',
        format => 'apache2',
        tag => 'apache.access_log',
        config => {
            'path' => '/var/log/apache2/access.log',
            'pos_file' => '/var/log/td-agent/td-agent.apache.pos',
        }
    }
    td_agent::configfile { 'forward': }
    td_agent::match { 'forward_main': 
        configfile => 'forward',
        pattern => 'mongo.*.*',
        type => 'forward',
        servers => [
            {'host' => '192.168.10.202', 'port' => '24224'}
        ],
    }

    td_agent::install_plugin {['fluent-plugin-mysqlslowquery','fluent-plugin-tail-multiline']:}
   # td_agent::install_plugin {'fluent-plugin-tail-multiline':}

}
