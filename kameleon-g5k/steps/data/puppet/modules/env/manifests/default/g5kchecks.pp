class env::default::g5kchecks {

  $g5kchecks_deps = [ 'ruby-rspec', 'ruby-rest-client', 'ohai', 'ruby-popen4', 'fio', 'rake', 'ruby-json' ]
  case $operatingsystem {
    'Debian','Ubuntu': {
      exec {
        "retrieve_g5kchecks":
          command  => "/usr/bin/wget --no-check-certificate -q https://www.grid5000.fr/packages/debian/g5kchecks_all.deb -O /tmp/g5kchecks_all.deb",
          creates  => "/tmp/g5kchecks_all.deb";
      }
      package {
        "g5kchecks":
          ensure   => installed,
          provider => dpkg,
          source   => "/tmp/g5kchecks_all.deb",
          require  => [ Exec["retrieve_g5kchecks"], Package[$g5kchecks_deps], Package['rake'], Package['ntp'] ];
        $g5kchecks_deps:
          ensure   => installed;
      }
    }
    default: {
      err "${operatingsystem} not suported."
    }
  }
}

