REM generate_share_index_nocache_timestamp_backtohome

@echo off
setlocal EnableDelayedExpansion

set "folder=share"
set "output=%folder%\index.html"

if not exist "%folder%" (
    echo Folder "%folder%" does not exist.
    goto :eof
)

rem Get current date and time
for /f "tokens=1-5 delims=/:. " %%a in ("%date% %time%") do (
    set "stamp=%%a-%%b-%%c %%d:%%e"
)

> "%output%" (
    echo ^<!DOCTYPE html^>
    echo ^<html lang="en"^>
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"^>
    echo     ^<meta http-equiv="Pragma" content="no-cache"^>
    echo     ^<meta http-equiv="Expires" content="0"^>
    echo     ^<title^>Shared Files^</title^>
    echo     ^<style^>
    echo         body {background-color:#121212;color:#e0e0e0;font-family:"Segoe UI",Tahoma,Verdana,sans-serif;margin:0;padding:2rem;}
    echo         h1 {text-align:center;margin-bottom:2rem;color:#fff;}
    echo         ul {list-style:none;padding:0;max-width:600px;margin:auto;}
    echo         li {background:#1e1e1e;margin:0.5rem 0;padding:1rem;border-radius:8px;transition:background 0.2s;}
    echo         li:hover {background:#333;}
    echo         a {color:#90caf9;text-decoration:none;font-size:1.1rem;}
    echo         a:hover {text-decoration:underline;}
    echo         .footer {text-align:center;margin-top:3rem;font-size:0.9rem;color:#888;}
    echo         .back-to-home {text-align:center;margin-top:2rem;}
    echo         .back-to-home a {color:#ffffff;text-decoration:none;font-size:1.2rem;border:2px solid #ff9900;padding:0.5rem 1rem;border-radius:5px;transition:background-color 0.3s ease;}
    echo         .back-to-home a:hover {background-color:#ff9900;color:#000;}
    echo     ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>📂 Shared Files^</h1^>
    echo     ^<ul^>
)

for %%F in ("%folder%\*") do (
    if /I not "%%~nxF"=="index.html" (
        if not "%%~aF"=="d" (
            echo         ^<li^>^<a href="%%~nxF"^>%%~nxF^</a^>^</li^> >> "%output%"
        )
    )
)

>> "%output%" (
    echo     ^</ul^>
    echo     ^<div class="back-to-home"^>^<a href="/"^>⬅ Back to Home^</a^>^</div^>
    echo     ^<div class="footer"^>Generated automatically via GitHub Actions<br>Last updated: !stamp!^</div^>
    echo ^</body^>
    echo ^</html^>
)

echo Done: %output% generated.
pause
