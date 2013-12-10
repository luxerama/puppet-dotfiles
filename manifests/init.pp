class luxerama::dotfiles {
  
  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"
  $localrc_dir = "${boxen::config::srcdir}/localrc"

  # Setting up repositories
  repository { $dotfiles_dir:
    source => "${::github_user}/dotfiles"
  }

  repository { $localrc_dir:
    source => "${::github_user}/localrc"
  }

  # Adding symlinks for dotfiles
  file { "${home}/.zshrc":
    ensure  => link,
    target  => "${dotfiles_dir}/zsh/zshrc.symlink",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.tmux.conf":
    ensure  => link,
    target  => "${dotfiles_dir}/tmux/tmux.symlink",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.vimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/vim/vimrc.symlink",
    require => Repository[$dotfiles_dir]
  }

  # Adding symlink for localrc
  file { "${home}/.localrc":
    ensure  => link,
    target  => "${localrc_dir}/localrc.symlink",
    require => Repository[$localrc_dir]
  }
}
