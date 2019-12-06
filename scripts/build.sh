#!/usr/bin/env zsh

# Script path
local scriptd="${0:a:h}"

build_extension()
{
  ### Bootstrap

    # Normalize environment
    emulate zsh -L

    # Workspace path [basedgod]
    local based="${scriptd:h}"

    ### Build Config
    local packaged="${based}/packages"


  ### Functions

    plog(){ print -P "%F{240}$@%f" } >/dev/null 1>&2
    perr(){ print -P "%F{red}$@%f" } >/dev/null 1>&2

    # npm/vsce package check
    vsce_install_check()
    {
        plog "Checking vsce dependency install..."
        if npm explore vsce --silent
        then
            plog "\tvsce installed."
            return 0
        else
            plog "\tvsce not installed"
            return 1
        fi
    }

    # vsce package install
    vsce_load()
    {
        # Skip if vsce installed.
        vsce_install_check && return 0

        plog "Installing vsce package..."
        # Install vsce
        npm install vsce --save-dev  && { return 0 } || {
            perr "Failed. Try %Bsudo npm install -g vsce%b? (%B%Uy%b%u/n)"
            read ans

            if (( $#line < 1 )) || [[ $line = "y*" ]]
            then
                npm install vsce --dev \
                    && { plog "%F{31}vsce installed.%f" && return 0 } \
                    || { perr "sudo install failed."    && return 1 }
            fi

            perr "Build cancelled."
            return 2
        }
    }

    package_extension()
    { #TODO: Function is kind of roomy in case later in time these things mitebcool
      # - More verbose/descriptive filenames
      # - Stop/warn on dupe packages of same version, also overriding the warning
      # - Prompt if you want bump the version on a repeat version (with changed code)
      # ...
        plog "Building extension package..."

        local extJson="${based}/package.json"
        if [[ ! -f $extJson ]]
        then
            perr "Extension package.json not found at: %B%U${extJson}%b%u"
            return 1
        fi

        local -A ext_info=(
            $(jq -r '"name \(.name) version \(.version)" | @text' $extJson) )
        local name=${ext_info[name]}
        local version=${ext_info[version]}

        if [[ ! ( -v name && -v version ) || "${ext_info}" = *null* ]]
        then
            perr "Failed to parse extension name and version from project.json"
            return 2
        fi

        local extension_vsix="$packaged/$name-$version.vsix"
        if vsce package --out ${extension_vsix}
        then
            plog "%F{31}Package created.\n\n > %U%B${packaged}%u%b%f"
            if [ $commands[exa] ]
            then
                exa -l -stime --reverse "${packaged}"
            else
                ls -l ${packaged}
            fi
            return 0

        else
            perr "Error building package: %U%B${extension_vsix}%u%b"
            return 3
        fi

        return 4
    }


  ### Setup

    # Check for npm
    plog "Checking for npm install..."
    if [[ $commands[npm] ]]
    then
    else
        perr "npm not installed."
        return 1
    fi

    # Go to main working path
    plog "Setting working directory to repo base directory..."
    if pushd -q $based >/dev/null 2>&1
    then
        trap '
            popd -q
        ' EXIT
    else
        perr "Failed setting working path to repo base (%U%B$based%u%b)"
        return 1
    fi

    # Check for/create missing packages dir
    plog "Checking for package destination path..."
    if  [[ ! -d "$packaged/" ]] || ! mkdir -p $packaged >/dev/null 2>&1
    then
        perr "Unable to find/create packages directory: %U$packaged%u"
        return 1
    fi

    # Check for/install vsce npm package if needed, exit if not successful
    vsce_load
    if (( $? > 0 )) { return 1 }

    # Generate package
    plog "%F{31}Creating package...%f"
    package_extension
}

(){
    pushd -q ${0:a:h} && {
        build_extension
    } always {
        popd -
    }
}