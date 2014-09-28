set action to button returned of (display dialog "ZFS Utils :: choose an action" buttons {"create", "destroy", "cancel"} default button "cancel")
--
if action is equal to "create" then
	set action to button returned of (display dialog "ZFS Utils" buttons {"create pool", "create dataset", "cancel"} default button "cancel")
	--
	if action is equal to "create pool" then
		set poolname to the text returned of (display dialog "ZFS pool name" default answer "tank")
		set devicedisk to the text returned of (display dialog "device disk" default answer "")
		do shell script "zpool create -d -o ashift=12 -o feature@async_destroy=enabled -o feature@empty_bpobj=enabled -o feature@lz4_compress=enabled -O compression=lz4 -O casesensitivity=insensitive -O atime=off -O normalization=formD -m /Volumes/" & poolname & " " & poolname & " " & devicedisk with administrator privileges
	else if action is equal to "create dataset" then
		set dataset to the text returned of (display dialog "ZFS dataset name" default answer "tank/dataset")
		do shell script "zfs create " & dataset with administrator privileges
	else if action is equal to "cancel" then
		
	else
		
	end if
else if action is equal to "destroy" then
	set action to button returned of (display dialog "ZFS Utils" buttons {"destroy dataset", "destroy pool", "cancel"} default button "cancel")
	if action is equal to "destroy pool" then
		set poolname to the text returned of (display dialog "destroy ZFS pool name: " default answer "tank")
		do shell script "zpool destroy -f " & poolname with administrator privileges
	else if action is equal to "destroy dataset" then
		set dataset to the text returned of (display dialog "destroy ZFS dataset: " default answer "tank/dataset")
		do shell script "zfs destroy " & dataset with administrator privileges
	else if action is equal to "cancel" then
		
	else
		
	end if
end if

