wally install
rojo sourcemap demo.project.json | Out-File -Encoding ASCII -FilePath sourcemap.json
wally-package-types --sourcemap sourcemap.json DevPackages/

$reactContents = "_G.__DEV__ = game:GetService('RunService'):IsStudio()`n"
$reactContents = $reactContents + (Get-Content -Path .\DevPackages\React.lua -Encoding ASCII -Raw)

Set-Content -Path .\DevPackages\React.lua -Value $reactContents -Encoding ASCII
