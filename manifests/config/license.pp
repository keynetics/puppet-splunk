#Private Class to Configure Splunk License Slave
class splunk::config::license (
  $server     = undef,
  $SPLUNKHOME = $::splunk::SPLUNKHOME
  ) {
  if ( $server == 'self' ) {
    $uri = $server
  } else {
    $uri = "https://${server}:8089"
  }
  if ( $server ) {
    ini_setting { 'Configure Splunk License':
      ensure  => present,
      path    => "${SPLUNKHOME}/etc/system/local/server.conf",
      section => 'license',
      setting => 'master_uri',
      value   => $uri,
      require => Class['splunk::install'],
      notify  => Class['splunk::service'],
    }
  }
}
