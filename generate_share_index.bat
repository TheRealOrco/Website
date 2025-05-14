@echo on
setlocal EnableDelayedExpansion

set "folder=share"
set "output=%folder%\index.html"

rem Check if the folder exists
if not exist "%folder%" (
    echo Warning: Folder "%folder%" does not exist.
    echo ^<html^><body^><h1^>No files found</h1^></body^></html^> > "%output%"
    goto :eof
)

> "%output%" (
    echo ^<html^>
    echo ^<head^>
    echo     ^<title^>Shared Files^</title^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>Files in /share/^</h1^>
    echo     ^<ul^>

    rem Loop through all files in the folder (ignore directories)
    for %%F in ("%folder%\*") do (
        rem Skip directories and the index.html itself
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
