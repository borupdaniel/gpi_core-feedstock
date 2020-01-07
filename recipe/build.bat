::@echo off

set UNPACK_DIR=repo_contents

# Move files to root dir to avoid a License file error 
robocopy /mov %UNPACK_DIR%\AUTHORS .\
robocopy /mov %UNPACK_DIR%\COPYING .\
robocopy /mov %UNPACK_DIR%\COPYING.LESSER .\
robocopy /mov %UNPACK_DIR%\LICENSE .\
robocopy /mov %UNPACK_DIR%\README.md .\

# Make the site-packages directory
mkdir -p %SP_DIR%\%PKG_NAME%

# Copy all of the appropriate things there
robocopy /E %UNPACK_DIR%\* %SP_DIR%\%PKG_NAME%
robocopy AUTHORS %SP_DIR%\%PKG_NAME%
robocopy COPYING %SP_DIR%\%PKG_NAME%
robocopy COPYING.LESSER %SP_DIR%\%PKG_NAME%
robocopy LICENSE %SP_DIR%\%PKG_NAME%
robocopy README.md %SP_DIR%\%PKG_NAME%

# Do the build in place in site-packages
:: cd $SP_DIR/$PKG_NAME
:: No gpi_make on windows at this time.
::gpi_make --all --ignore-system-libs --ignore-gpirc -r 3

# drop a version file with parseable info
set VERSION_FPATH=%SP_DIR%/%PKG_NAME%/VERSION
::@echo off
@echo PKG_NAME: %PKG_NAME% > %VERSION_FPATH%
@echo PKG_VERSION: %PKG_VERSION% >> %VERSION_FPATH%
@echo PKG_BUILD_STRING: %PKG_BUILD_STRING% >> %VERSION_FPATH%
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (SET BUILD_DATE=%%c-%%a-%%b)
@echo BUILD_DATE: %BUILD_DATE% >> %VERSION_FPATH%
