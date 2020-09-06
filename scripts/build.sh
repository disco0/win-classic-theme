#!/usr/bin/env zsh

# Script path
local scriptd="${0:a:h}"

# Check for immediate install
unset OPT_INSTALL
zparseopts -E -D -K -- {i,-install}'=OPT_INSTALL'

build_extension()
{
  #region Bootstrap

    # Normalize environment
    emulate zsh -L

    # Workspace path [basedgod]
    local based="${scriptd:h}"

    ### Build Config
    local packaged="${based}/packages"


  #endregion
  #region Definitions

  # Paramter expansion to determine vsce path
  local vsce_path_expn='${${commands[vsce]}-./node_modules/vsce/out/vsce}'

  #endregion
  #region Functions

    plog(){ builtin print -Pu2 -- "%F{240}$@%f" }
    perr(){ builtin print -Pu2 -- "%F{red}$@%f" }

    # vsce in PATH or node_modules
    vsce_path()
    {
        builtin print -r -- "${${commands[vsce]}-./node_modules/vsce/out/vsce}"
    }

    # npm/vsce package check
    vsce_install_check()
    {
        plog "Checking vsce dependency install..."
        local vsce_path="${(e)vsce_path_expn}"
        if [[ -e $vsce_path ]]
        then
            plog "         vsce installed."
            return 0
        else
            plog "        %F{1}vsce not install failed.%f"
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
        local vsce_path="${(e)vsce_path_expn}"
        if $=vsce_path package --out ${extension_vsix}
        then
            plog "%F{31}Package created.\n\n > %U%B${packaged}%u%b%f"
            if [ $commands[exa] ]
            then
                exa -l -stime --reverse "${packaged}"
            else
                ls -l ${packaged}
            fi


            if (( $+OPT_INSTALL ))
            then
                plog "%F{31}Install flag passed, installing for all code versions%f"

                # Find best executables
                local -a code_commands=( ${(kM)commands:#code(-insiders|)(|.cmd)} )
                if [[ -n ${(M)code_commands:#*cmd} ]]
                then
                    # WSL Mode
                    builtin alias -s cmd='cmd.exe /C '
                    code_commands=( 'cmd.exe /C '${(M)^code_commands:#*.cmd} )
                    extension_vsix="$(wslpath -w $extension_vsix)"
                fi

                foreach code ( ${(@)^code_commands} )
                    $=code --install-extension "$extension_vsix" --force
                end
            fi

            return 0

        else
            perr "Error building package: %U%B${extension_vsix}%u%b"
            return 3
        fi

        return 4
    }


  #endregion
  #region Setup

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

  #endregion
}

(){
    pushd -q ${0:a:h} && {
        build_extension
    } always {
        popd -
    }
}