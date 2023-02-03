$PowerShellProfile = $PROFILE.CurrentUserAllHosts
$PowerShellPath = Split-Path $PowerShellProfile
Import-Module $PowerShellPath\Modules\VirtualEnvWrapper.psm1

Register-ArgumentCompleter -Native -CommandName workon -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $WORKON_HOME=$Env:WORKON_HOME

    if (!$WORKON_HOME) {
        $WORKON_HOME = "$Env:USERPROFILE\Envs"
    }

    (Get-ChildItem -Path $WORKON_HOME).Name | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
          "$_"
    }
}
