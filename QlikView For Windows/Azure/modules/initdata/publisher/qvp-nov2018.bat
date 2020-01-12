cd C:\ 
mkdir QV-Install 
cd QV-Install 
curl https://da3hntz84uekx.cloudfront.net/qlikview/12.30/123020300/_MSI/QlikViewServer_x64Setup.exe --output QlikViewServer_x64Setup.exe 
QlikViewServer_x64Setup.exe /s /x /b"C:\QV-Install" /v"/qn" 
timeout 5
msiexec /i QlikViewServerx64.msi ADDLOCAL="ManagementService,DistributionService,DirectoryServiceConnector" /L*v log.txt /qn+