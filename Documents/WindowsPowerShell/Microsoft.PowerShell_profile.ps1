###############################
#                             #
#     My Windows PS config    #
#                             #
#        Last revision:       #
#          2020-05-09         #
#                             #
###############################

### env {{{
$Env:EDITOR = 'nvim'
### }}}

### powershell {{{
function prompt
{
	Write-Prompt ">" -NoNewLine -ForegroundColor "Red"
	return " "
}

Set-PSReadlineOption -EditMode vi -BellStyle None # vi mode

# Run this if you have trouble with ANSI colors
# Set-ItemProperty HKCU:\Console VirtualTerminalLevel -Type DWORD 1 # VTerminal
### }}}

### aliases {{{
function poshconfig { Invoke-Expression "$Env:EDITOR $PROFILE" }
function gitconfig { Invoke-Expression "$Env:EDITOR $HOME/.gitconfig" }
function vimrc { Invoke-Expression "$Env:EDITOR $HOME/.vimrc" }
function nvimrc { Invoke-Expression "$Env:EDITOR $HOME/AppData/Local/nvim/init.vim" }
function termconfig { Invoke-Expression "$Env:EDITOR $HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" }

Set-Alias e "$Env:EDITOR" -option ReadOnly
Set-Alias ielixir "C:\ProgramData\chocolatey\lib\Elixir/bin\iex.bat" -option ReadOnly
### }}}

### imports {{{
Import-Module PSReadline
Remove-PSReadlineKeyHandler -chord Ctrl+r -vimode command
Remove-PSReadlineKeyHandler -chord Ctrl+t -vimode insert

Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'

Import-Module posh-git
### }}}
