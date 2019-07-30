#!/usr/bin/env zsh

### Script

  # Script path
  local scriptd="${0:a:h}"

  # Normalize environment
  emulate zsh -L


### Build Config

  local package_path="${scriptd}/packages"


### Functions

  print_err(){ print -P "%F{red}$@%f" } >/dev/null 1>&2

  # npm/vsce package check
  __npm_vsce_install_check()
  { [[ "$(npm list -g --parseable vsce)" == *vsce ]] && return 0 || return 1 }

  # vsce package install
  __npm_vsce_load()
  { __npm_vsce_install_check && return 0 #? Skip if vsce installed.

    # Install vsce
    npm install vsce --dev  && { return 0 } || {
        print_err "Failed.  Try %Bsudo npm install -g vsce%b? (%By%b/n)"; read ans

        if (( $#line < 1 )) || [[ $line = "y*" ]]
        then
            npm install vsce --dev \
                && { print -P  "%F{31}vsce package installed." && return 0 } \
                || { print_err "sudo install failed."          && return 1 }
        fi

        print_err "Build cancelled."
        return 2
    }
  }


### Setup

  # Check for npm
  [[ ! $commands[npm] ]] && print_err "npm not installed." && return 1

  # Create packages dir
  if ! ( [[ ! -d "$package_path/" ]] || mkdir -p $package_path )
  then
    print_err "Unable to find/create packages directory %U$package_path%u" \
    return 1
  fi

  # Check for, and install vsce package if needed, exit if not successful
  __npm_vsce_install_check
  if (( $? > 0 )) { return 1 }


# Generate package

print -P "%F{31}Creating package..." 1>/dev/null 1>&2
if vsce package
then
    ls ${0:a:h}
    mv *.vsix(om[1]) $package_path/
else
    print_err "Error building package."
fi

