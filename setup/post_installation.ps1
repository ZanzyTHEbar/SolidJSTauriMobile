
function Install-Rustup {
    $rustup = Get-Command rustup -ErrorAction SilentlyContinue
    if ($rustup) {
        Write-Host "Rustup is already installed" -ForegroundColor Green
        Write-Host "Installing Rust Android Toolchain ABI's" -ForegroundColor Green
        & rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
        return
    }

    Write-Host "Installing Rustup" -ForegroundColor Green
    Invoke-WebRequest -Uri https://sh.rustup.rs -OutFile rustup-init.exe
    .\rustup-init.exe -y
    Remove-Item rustup-init.exe

    Write-Host "Installing Rust Android Toolchain ABI's" -ForegroundColor Green
    & rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
}

& Install-Rustup