## puppet-module-fluentd

manage fluent and install fluent-plugin by puppet

first,install puppet-concat module: puppet module install puppetlabs-concat
      
## Usage

### create source file
``` include "td_agent"
    include concat::setup

    tdgent::configfile { 'syslog': }
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
```

### create match file
```
    include "td_agent"
    include concat::setup

    td_agent::configfile { 'forward': }
    td_agent::match { 'forward_main': 
        configfile => 'forward',
        pattern => 'mongo.*.*',
        type => 'forward',
        servers => [
            {'host' => '192.168.10.202', 'port' => '24224'}
        ],
    }
```

### install fluentd-plugin
```

    include "td_agent"
    include concat::setup
    td_agent::install_plugin {['fluent-plugin-mysqlslowquery','fluent-plugin-tail-multiline']:}
```

