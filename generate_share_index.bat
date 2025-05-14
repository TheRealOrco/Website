@echo on
setlocal EnableDelayedExpansion

echo Current directory:
cd

dir

set "folder=share"
set "output=%folder%\index.html"

rem Check if the folder exists
if not exist "%folder%" (
    echo Error: Folder "%folder%" does not exist.
    pause
    exit /b 1
)

> "%output%" (
    echo ^<html^>
    echo ^<head^>
    echo     ^<title^>Shared Files^</title^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>Files in /share/^</h1^>
    echo     ^<ul^>

    for %%F in ("%folder%\*") do (
        if /I not "%%~nxF"=="index.html" (
            if not "%%~aF"=="d" (
                echo         ^<li^>^<a href="%%~nxF"^>%%~nxF^</a^>^</li^>
            )
        )
    )

    echo     ^</ul^>
    echo ^</body^>
    echo ^</html^>
)

echo Done: %output% generated.
pause
