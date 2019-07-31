#!/usr/bin/env zsh

build_extension()
{
  ### Bootstrap

    # Normalize environment
    emulate zsh -L

    # Script path
    local scriptd="${0:a:h}"

    # Workspace path [basedgod]
    local based="${scriptd:h}"

    ### Build Config
    local packaged="${based}/packages"


  ### Functions

    print_err(){ print -P "%F{red}$@%f" } >/dev/null 1>&2

    # npm/vsce package check
    vsce_install_check()
    { [[ "$(npm list -g --parseable vsce)" == *vsce ]] && return 0 || return 1 }

    # vsce package install
    vsce_load()
    {
        #? Skip if vsce installed.
        vsce_install_check && return 0

        # Install vsce
        npm install vsce --dev  && { return 0 } || {
            print_err "Failed. Try %Bsudo npm install -g vsce%b? (%By%b/n)"
            read ans

            if (( $#line < 1 )) || [[ $line = "y*" ]]
            then
                npm install vsce --dev \
                    && { print -P  "%F{31}vsce installed.%f" && return 0 } \
                    || { print_err "sudo install failed."    && return 1 }
            fi

            print_err "Build cancelled."
            return 2
        }
    }

    package_extension()
    { #TODO: Function is kind of roomy in case later in time these things mitebcool
      # - More verbose/descriptive filenames
      # - Stop/warn on dupe packages of same version, also overriding the warning
      # - Prompt if you want bump the version on a repeat version (with changed code)
      # ...

        local extJson="${based}/package.json"
        if [[ ! -f $extJson ]]
        then
            print_err "Extension package.json not found at: %B%U${extJson}%b%u"
            return 1
        fi

        local    name=${"$(jq '.name'    $extJson )"//\"/}
        local version=${"$(jq '.version' $extJson )"//\"/}
        if [[ ! ( -v name && -v version ) ]]
        then
            print_err "Failed to parse extension name and version from project.json"
            return 2
        fi

        local extension_vsix="$packaged/$name-$version.vsix"
        if vsce package --out ${extension_vsix}
        then
            print -P "\n%F{31}Package created.\n  %U%B>${packaged}:%u%b%f\n"
            ls ${packaged}
            return 0
            
        else
            print_err "Error building package: %U%B${extension_vsix}%u%b"
            return 3
        fi

        return 4 #????
    }

  ### Setup

    # Check for npm
    [[ ! $commands[npm] ]] && print_err "npm not installed." && return 1

    # Go to main working path
    if pushd -q $based >/dev/null 2>&1
    then
        trap '
            popd -q
        ' EXIT
    else
        print_err "Failed setting working path to repo base (%U%B$based%u%b)"
        return 1
    fi

    # Check for/create missing packages dir
    if  [[ ! -d "$packaged/" ]] || ! mkdir -p $packaged >/dev/null 2>&1
    then
        print_err "Unable to find/create packages directory: %U$packaged%u"
        return 1
    fi

    # Check for/install vsce npm package if needed, exit if not successful
    vsce_load
    if (( $? > 0 )) { return 1 }

    # Generate package
    print -P "%F{31}Creating package...%f" 1>/dev/null 1>&2
    package_extension
}

build_extension

