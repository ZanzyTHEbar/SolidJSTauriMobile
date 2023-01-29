function Install-Rustup {
    Write-Host "Please follow the Tauri documentation" -ForegroundColor Green
    Start-Process "https://next--tauri.netlify.app/next/guides/getting-started/prerequisites/windows"

    Write-Host "Checking if Rustup is already installed" -ForegroundColor Green
    $rustup = Get-Command rustup -ErrorAction SilentlyContinue
    if ($rustup) {
        Write-Host "Rustup is already installed" -ForegroundColor Green
        Write-Host "Setting Rust Toolchain version" -ForegroundColor Green
        rustup default stable-msvc
        
        return
    }

    Write-Host "Installing Rustup" -ForegroundColor Green
    winget install --id Rustlang.Rustup

    Write-Host "Setting Rust Toolchain version" -ForegroundColor Green
    rustup default stable-msvc
}


