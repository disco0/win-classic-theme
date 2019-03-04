#!/usr/bin/env zsh
# setopt xtrace
print_err(){ print -P "%F{red}$@%f"  }

# Exit if no npm
[ ! $commands[npm] ] && print_err "npm not installed." && return 1

# Create packages dir
local package_path="${0:a:h}/packages"
if [[ -d "$package_path/" ]] \
then
    mkdir -p $package_path || { print_err "unable to find/create packages directory [ %U$package_path%u ]" && return 1 }
fi

# Check for and install vsce if needed
npm list -g | grep vsce *>/dev/null \
    || npm install -g vsce --no-shrinkwrap \
    || { print -P "Try %Bsudo npm install -g vsce%b? (%By%b/n)"
         read ans
         if (( $#line < 1 )) || [[ $line = "y*" ]]
         then 
             sudo npm install -g vsce --no-shrinkwrap || print_err "sudo install failed." && return 1
         fi
       }

# Generate package
if vsce package -o $package_path/
then
    mv *.vsix(om[1])
else
    print_err "Error building package."
fi

# unsetopt xtrace