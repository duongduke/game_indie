$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

foreach ($tool in @('javac', 'jar', 'jpackage')) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        throw "Missing $tool. Install JDK 21 or newer and add its bin directory to PATH."
    }
}

# Each build gets its own directory so earlier packages remain usable.
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$build = Join-Path $PSScriptRoot "build\$stamp"
$classes = Join-Path $build 'classes'
$inputDir = Join-Path $build 'input'
$destination = Join-Path $PSScriptRoot "dist\$stamp"
New-Item -ItemType Directory -Force $classes, $inputDir, $destination | Out-Null
$sources = @(Get-ChildItem src -Recurse -Filter '*.java' | ForEach-Object FullName)
& javac --release 17 -encoding UTF-8 -d $classes @sources
if ($LASTEXITCODE -ne 0) { throw 'Java compilation failed.' }
& jar --create --file "$inputDir\Dungeon01.jar" --main-class main.Main -C $classes . -C res .
if ($LASTEXITCODE -ne 0) { throw 'JAR creation failed.' }
& jpackage --type app-image --name Dungeon01 --app-version 1.0.0 --vendor game_indie --input $inputDir --main-jar Dungeon01.jar --main-class main.Main --add-modules java.desktop --dest $destination
if ($LASTEXITCODE -ne 0) { throw 'Windows packaging failed.' }
@'
DUNGEON01 - WINDOWS

Extract the entire ZIP, then double-click Dungeon01.exe.
Keep app/ and runtime/ next to the EXE. Java installation is not required.

Menu: W / S, Enter to select.
See the in-game controls for gameplay keys.
'@ | Set-Content "$destination\Dungeon01\START-HERE.txt" -Encoding UTF8
$zip = Join-Path $destination 'Dungeon01-Windows.zip'
Compress-Archive -Path "$destination\Dungeon01" -DestinationPath $zip
Write-Host "Game: $destination\Dungeon01\Dungeon01.exe"
Write-Host "ZIP:  $zip"
