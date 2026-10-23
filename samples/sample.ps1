# Sample fixture for Nautilus PowerShell token roles.

using namespace System.Collections.Generic
#Requires -Version 7.0

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string] $Name = 'world',

    [switch] $VerboseSwitch
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Greeting {
    [OutputType([string])]
    param(
        [string] $Target
    )

    return "Hello, $Target"
}

<#
.SYNOPSIS
    Demonstrates PowerShell token roles.
.PARAMETER Name
    Person to greet.
#>
function Show-Sample {
    param(
        [string] $Name
    )

    $local:count = 1
    $script:shared = 2
    $global:flag = $true

    $env:PATH
    $PWD.Path
    $_
    $PSScriptRoot
    $MyInvocation.MyCommand.Name

    if ($Name -eq 'world' -and $count -gt 0) {
        Write-Host (Get-Greeting -Target $Name)
    }
    elseif ($Name -match 'test' -or $Name -like 'demo*') {
        Write-Warning "Matched $Name"
    }
    else {
        Write-Error "Unexpected name"
    }

    $numbers = 1..5
    $mask = 0xFF -band 0x0F
    $list = @(
        'one'
        "two-$Name"
        @'
literal here-string
'@
        @"
expandable here-string $Name
"@
    )

    $map = @{
        First = $list[0]
        Second = $list[1]
    }

    Get-ChildItem -Path $PSScriptRoot -File | ForEach-Object {
        $_.FullName
    }

    try {
        1 / 0
    }
    catch {
        Write-Verbose $_.Exception.Message
    }
    finally {
        Write-Output $map.First
    }
}

Show-Sample -Name $Name
