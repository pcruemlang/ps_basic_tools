Function Get-MonitorInfo
{
    [CmdletBinding()]
 Param
    (
        [Parameter(mandatory=$true)]
        [string]$strComputer 
        
Get-WmiObject -Namespace root\wmi -Class wmiMonitorID -ComputerName $strComputer  | foreach {
	New-Object -TypeName psobject -Property @{
        Manufacturer = ($_.ManufacturerName -notmatch '^0$' | foreach {[char]$_}) -join ""
        Name = ($_.UserFriendlyName -notmatch '^0$' | foreach {[char]$_}) -join ""
        Serial = ($_.SerialNumberID -notmatch '^0$' | foreach {[char]$_}) -join ""
    }
    }

get-wmiobject -namespace root\WMI -computername $strComputer -Query "Select * from WmiMonitorConnectionParams" |  foreach {
 switch ($_.VideoOutputTechnology) { 
        -2          {$VideoOutputTechnology = 'Uninitialized connector' }                                                   # D3DKMDT_VOT_UNINITIALIZED         
        -1          { $VideoOutputTechnology ='Unknown connector' }                                                         # D3DKMDT_VOT_OTHER                 
        0           { $VideoOutputTechnology ='VGA connector' }                                                             # D3DKMDT_VOT_HD15                  
        1           { $VideoOutputTechnology ='S-video connector' }                                                         # D3DKMDT_VOT_SVIDEO                
        2           { $VideoOutputTechnology ='Composite video connector' }                                                 # D3DKMDT_VOT_COMPOSITE_VIDEO       
        3           { $VideoOutputTechnology ='Component video connector' }                                                 # D3DKMDT_VOT_COMPONENT_VIDEO       
        4           { $VideoOutputTechnology ='Digital Video Interface (DVI) connector' }                                   # D3DKMDT_VOT_DVI                   
        5           { $VideoOutputTechnology ='High-Definition Multimedia Interface (HDMI) connector' }                     # D3DKMDT_VOT_HDMI                  
        6           { $VideoOutputTechnology ='Low Voltage Differential Swing (LVDS) or Mobile Industry Processor Interface (MIPI) Digital Serial Interface (DSI) connector' }  # D3DKMDT_VOT_LVDS                  
        8           { $VideoOutputTechnology ='D-Jpn connector' }                                                           # D3DKMDT_VOT_D_JPN                 
        9           { $VideoOutputTechnology ='SDI connector' }                                                             # D3DKMDT_VOT_SDI                   
        10          { $VideoOutputTechnology ='External display port' }                                                     # D3DKMDT_VOT_DISPLAYPORT_EXTERNAL  
        11          { $VideoOutputTechnology ='Embedded display port' }                                                     # D3DKMDT_VOT_DISPLAYPORT_EMBEDDED  
        12          { $VideoOutputTechnology ='External Unified Display Interface (UDI)' }                                  # D3DKMDT_VOT_UDI_EXTERNAL          
        13          { $VideoOutputTechnology ='Embedded Unified Display Interface (UDI)' }                                  # D3DKMDT_VOT_UDI_EMBEDDED          
        14          { $VideoOutputTechnology ='Dongle cable that supports SDTV connector' }                                 # D3DKMDT_VOT_SDTVDONGLE            
        15          { $VideoOutputTechnology ='Miracast connected session' }                                                # D3DKMDT_VOT_MIRACAST              
        0x80000000  { $VideoOutputTechnology ='Internally display device (the internal connection in a laptop computer)' }  # D3DKMDT_VOT_INTERNAL              
        default     { $VideoOutputTechnology ='Unknown connector' }
    }#switch
"Screen connected with : $VideoOutputTechnology"
}
}
