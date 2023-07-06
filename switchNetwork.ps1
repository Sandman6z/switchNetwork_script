# 获取无线网络适配器的名称
$wirelessAdapterName = Get-NetAdapter | Where-Object { $_.InterfaceDescription -like '*Wireless*' } | Select-Object -ExpandProperty Name

# 获取有线网络适配器的名称
$wiredAdapterName = Get-NetAdapter | Where-Object { $_.InterfaceDescription -like '*Realtek*' } | Select-Object -ExpandProperty Name

# 切换到无线网络
function SwitchToWireless 
{
    # 禁用有线网络适配器
    Disable-NetAdapter -Name $wiredAdapterName

    # 启用无线网络适配器
    Enable-NetAdapter -Name $wirelessAdapterName

    Write-Host "已切换到无线网络"
}

# 切换到有线网络
function SwitchToWired 
{
    # 禁用无线网络适配器
    Disable-NetAdapter -Name $wirelessAdapterName

    # 启用有线网络适配器
    Enable-NetAdapter -Name $wiredAdapterName

    Write-Host "已切换到有线网络"
}

# 切换网络
function SwitchNetwork 
{
    $currentAdapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object -ExpandProperty Name

    if ($currentAdapter -eq $wirelessAdapterName) 
    {
        SwitchToWired
    }
    elseif ($currentAdapter -eq $wiredAdapterName) 
    {
        SwitchToWireless
    }
    else 
    {
        Write-Host "无法识别当前网络适配器`n"
        Write-Host $wirelessAdapterName
        Write-Host $wiredAdapterName
    }
}

# 使用示例：切换网络
SwitchNetwork
