#!/bin/zsh
#set -x

############################################################################################
##
## Script to set the Policy Banner
##
############################################################################################

## Copyright (c) 2025 Microsoft Corp. All rights reserved.
## Scripts are not supported under any Microsoft standard support program or service. The scripts are provided AS IS without warranty of any kind.
## Microsoft disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a
## particular purpose. The entire risk arising out of the use or performance of the scripts and documentation remains with you. In no event shall
## Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever
## (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary
## loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility
## of such damages.
## Feedback: ckunze@microsoft.com

# Define variables
appname="PolicyBanner"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
PolicyBannerFile="/Library/Security/PolicyBanner.txt"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    # Already created
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    # Creating Metadirectory
    echo "$(date) | creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir"
fi

# Start logging
exec &> >(tee -a "$log")

# Begin Script Body
echo ""
echo "##############################################################"
echo "# $(date) | Starting running of script $appname"
echo "############################################################"
echo ""

# remove the file if it exists
rm -f "$PolicyBannerFile"  

# create the file with the banner text
echo "$(date) | Creating the Policy Banner file stating:"
echo "this information system is the property of Kelly Benefits. This information system, including all related equipment, networks, and network devices (specifically including internet access), are provided only for authorized employees of Kelly Benefits and other authorized employees. Any or all use of this system may be intercepted, monitored, recorded and audited for all lawful purposes, including to ensure their use is authorized, for management of the system, to facilitate protection against unauthorized access and to verify security procedures. Unauthorized or improper use of this system may result in disciplinary action up to and including termination of employment, and/or civil charges/criminal penalties, and/or prosecution by law. Evidence of unauthorized use collected during monitoring may be used for administrative, criminal, or other adverse action. By continuing to use this system, you indicate your awareness of and consent to these terms and conditions of use" | tee $PolicyBannerFile 
sleep 5s

# Check if file was created successfully
if [ -f "$PolicyBannerFile" ]; then
    # creation succeeded
    echo "$(date) | Policy Banner file created successfully"

    # set the permissions on the file
    chmod o+r "$PolicyBannerFile"
    echo "$(date) | Permissions set on Policy Banner file"
  
else
    # creation failed
    echo "$(date) | Policy Banner file creation failed"
fi


