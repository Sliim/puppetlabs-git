define git::config(
  $value,
  $section  = regsubst($name, '^([^\.]+)\.([^\.]+)$','\1'),
  $key      = regsubst($name, '^([^\.]+)\.([^\.]+)$','\2'),
  $user     = inline_template('<%= ENV["USER"] %>'),
  $home     = inline_template('<%= ENV["HOME"] %>'),
) {
  exec{"git config --global ${section}.${key} '${value}'":
    environment => "HOME=${home}",
    path        => ['/usr/bin', '/bin'],
    unless      => "git config --global --get ${section}.${key} '${value}'",
    user        => $user,
    cwd         => $home,
  }
}
