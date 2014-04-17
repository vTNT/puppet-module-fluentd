## puppet-module-fluentd

manage fluent and install fluent-plugin by puppet

puppet-concat module: puppet module install puppetlabs-concat

os: CentOS 6.x
      
## Usage

### create source file
``` 
    include "td_agent"
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
        pattern => 'es.audit.*',
        type => 'forward',
        servers => [
            {'host' => '192.168.10.202', 'port' => '24224'}
        ],
    }
```

### create forward file (open forward port)
```
    include "td_agent"
    include concat::setup

    td_agent::configfile { 'forward': }
    td_agent::forward { 'forward_main': 
        configfile => 'forward',
        type => 'forward',
        servers => [
            {'bind' => '192.168.10.202', 'port' => '24224'}
        ],
    }
```

### install fluentd-plugin
```
    include "td_agent"
    include concat::setup
    td_agent::install_plugin {['fluent-plugin-mysqlslowquery','fluent-plugin-tail-multiline']:}
```

### input data into es
```
    td_agent::configfile { 'es_audit': }
     td_agent::es{ 'audit_main':
         configfile => 'es_audit',
         pattern => 'es.audit.*',
         type_name => 'audit',
         servers => [
       {'host' => 'fluent.server.com', 'port' => '9200'}
     ],
   }
 
     td_agent::install_plugin {['fluent-plugin-elasticsearch']:}
```
