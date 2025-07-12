@echo off
chcp 65001 >nul
echo ========================================
echo        SenderInfo 官方WCL修复工具
echo ========================================
echo.

set "ARCHON_DIR=..\\ArchonTooltip"
set "PROVIDER_FILE=%ARCHON_DIR%\\provider.lua"

if not exist "%ARCHON_DIR%" (
    echo [错误] 未找到ArchonTooltip插件目录
    echo 请安装官方WCL插件后尝试
    echo 请确保ArchonTooltip和SenderInfo都在同一个AddOns目录下
    pause
    exit /b 1
)

if not exist "%PROVIDER_FILE%" (
    echo [错误] 未找到provider.lua文件
    echo 文件路径: %PROVIDER_FILE%
    pause
    exit /b 1
)

echo [成功] 找到ArchonTooltip插件
echo 正在检查provider.lua文件...

findstr /c:"_G[\"ArchonTooltipPrivate\"] = Private" "%PROVIDER_FILE%" >nul
if %errorlevel% equ 0 (
    echo [信息] provider.lua文件已包含正确的配置
    echo 无需进行修复操作
) else (
    echo [信息] 发现配置缺失，正在修复...
    echo. >> "%PROVIDER_FILE%"
    echo _G["ArchonTooltipPrivate"] = Private >> "%PROVIDER_FILE%"
    echo [成功] 修复完成！
    echo 已在provider.lua文件末尾添加: _G["ArchonTooltipPrivate"] = Private
)

echo.
echo ========================================
echo 修复操作完成！
echo.
echo 请执行以下操作之一
echo 1. 在游戏聊天框中输入 /reload 重载插件
echo 2. 或者重新登录游戏
echo.
echo 修复完成后，SenderInfo插件将能够正常获取WCL数据
echo ========================================
pause