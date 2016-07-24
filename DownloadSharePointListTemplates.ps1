
Try {


#Site url from where the list is downloaded
$sourceWebUrl = "http://dell-pc/NNGRITS/";
$SprintName="Sprint3"

$lists = @("CustomList1",

"CustomList2");
$web=Get-SPWeb $sourceWebUrl
foreach($list in $lists)
{
    "Saving lists as template in template gallary  " + $sourceWebUrl + "/lists/" + $list
	$listref = $web.Lists[$list]	
    if ($list -eq "CustomList1") {    
    $listref.SaveAsTemplate($SprintName+$list+"_Template.stp",$list+"Template Title",$list+" Template Description",0)
    }
    else{
    $listref.SaveAsTemplate($SprintName+$list+"_Template.stp",$list+"Template Title",$list+" Template Description",1)
    }
}

$SPSite = Get-SPSite "http://dell-pc/"
$SPWeb = $SPSite.OpenWeb()
$files = $SPWeb.GetFolder("_catalogs/lt").Files

foreach ($file in $files) {
    "Downloading stp files "+ $file.Name
    $b = $file.OpenBinary()
    $fs = New-Object System.IO.FileStream(("C:\Listbackupfilepath\"+$file.Name), [System.IO.FileMode]::Create)
    $bw = New-Object System.IO.BinaryWriter($fs)
    $bw.Write($b)
    $bw.Close()
}
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    #Send-MailMessage -From ExpensesBot@MyCompany.Com -To WinAdmin@MyCompany.Com -Subject "HR File Read Failed!" -SmtpServer EXCH01.AD.MyCompany.Com -Body "We failed to read file $FailedItem. The error message was $ErrorMessage"
    Break
}
