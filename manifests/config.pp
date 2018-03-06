# class managing aide configuration.
class aide::config (
  $conf_path,
  $db_path,
  $db_temp_path,
  $gzip_dbout,
  $aide_log,
  $syslogout,
  $config_template,
) {

  if ($db_path =~ /(.*\/)(.*\.db.*)/) {
    $db_path_name = $1
    $db_file_name = $2
  }

  if ($db_temp_path =~ /(.*\/)(.*\.db\.new.*)/) {
    $db_temp_path_name = $1
    $db_temp_file_name = $2
  }

  concat { 'aide.conf':
    path  => $conf_path,
    owner => 'root',
    group => 'root',
    mode  => '0600',
  }

  concat::fragment { 'aide.conf.header':
    target  => 'aide.conf',
    order   => 01,
    content => template( $config_template ),
  }

  concat::fragment { 'rule_header':
    target  => 'aide.conf',
    order   => '02',
    content => "# User defined rules\n",
  }

  concat::fragment { 'watch_header':
    target  => 'aide.conf',
    order   => '45',
    content => "\n# Files and directories to scan\n",
  }

}
