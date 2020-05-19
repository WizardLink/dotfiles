###############################
#                             #
#     My Windows PS config    #
#                             #
#        Last revision:       #
#          2020-05-09         #
#                             #
###############################
#                             #
#       Modules needed:       #
#       - PSReadline          #
#       - PSFzf               #
#       - posh-git            #
#                             #
###############################
#
# This configuration usually sits at $Home\Documents\WindowsPowerShell

### env {{{
$Env:EDITOR = 'vim'
### }}}

### powershell {{{
function prompt
{
	Write-Prompt ">" -NoNewLine -ForegroundColor "Red"
	return " "
}

# Run this if you have trouble with ANSI colors
# Set-ItemProperty HKCU:\Console VirtualTerminalLevel -Type DWORD 1 # VTerminal
### }}}

### modules {{{
Import-Module PSReadline
Remove-PSReadlineKeyHandler -chord Ctrl+r -vimode command
Remove-PSReadlineKeyHandler -chord Ctrl+t -vimode insert
Set-PSReadlineOption -EditMode vi -BellStyle None # vi mode

Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'

Import-Module posh-git
### }}}

### aliases {{{
function poshconfig { Invoke-Expression "$Env:EDITOR $PROFILE" }
function gitconfig { Invoke-Expression "$Env:EDITOR $HOME/.gitconfig" }
function vimrc { Invoke-Expression "$Env:EDITOR $HOME/.vimrc" }
function termconfig { Invoke-Expression "$Env:EDITOR $HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" }

Set-Alias ielixir "C:\ProgramData\chocolatey\lib\Elixir/bin\iex.bat" -option ReadOnly
### }}}
