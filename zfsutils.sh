#!/bin/bash
#
#pool_list=`sudo zpool list | grep -n 2 | cut -d ":" -f2`
pool_list=`sudo zpool list`
dataset_list=`sudo zfs list`
#
clear
echo ":::::::::::::::::::::::::::::::::::"
echo "::::::::::: ZFS Manager :::::::::::"
echo ":::::::::::::::::::::::::::::::::::"
echo -n "Select menu number below"
echo ""
echo "1. Create ZFS pool"
echo "2. Create ZFS dataset"
echo "3. Import ZFS pool"
echo "4. Export ZFS pool"
echo "5. Destroy ZFS pool"
echo "6. List ZFS pool"
echo "7. List ZFS dataset"
echo "8. Scrub ZFS pool"
echo "9. Destroy dataset"
echo "0. Quit"
echo -n "Menu selection:" && read action
#
if [ $action == "1" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo "::::::::: Create ZFS pool :::::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo -n "Enter pool name (eg.: tank): " && read poolname
	echo -n "Enter device disk (eg.: /dev/diskX): " && read disk
	sudo zpool create -d \
	-o ashift=12 \
	-o feature@async_destroy=enabled \
	-o feature@empty_bpobj=enabled \
	-o feature@lz4_compress=enabled \
	-O compression=lz4 \
	-O casesensitivity=insensitive \
	-O atime=off \
	-O normalization=formD \
	-m /Volumes/$poolname \
	$poolname $disk
	sudo chown -R will:staff /Volumes/$poolname
fi
if [ $action == "2" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo ":::::::: Create ZFS dataset :::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS pool list >>"
	echo "$pool_list"
	echo ""
	echo -n "Select pool (enter pool name): " && read pool
	echo -n "Enter dataset name: " && read dataset
	echo -n "Enter dataset size (eg.: 10G - none): " && read quota
	if [ $quota == "" ]; then
		$quota=none
	fi
	sudo zfs create $pool/$dataset && \
	sudo zfs set quota=$quota $pool/$dataset
	sudo chown -R will:staff /Volumes/$pool/$dataset
fi
if [ $action == "3" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo "::::::::: Import ZFS pool :::::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS pool list >>"
	echo "$pool_list"
	echo ""
	echo -n "Select pool (enter pool name): " && read pool
	sudo zpool import $pool
fi
if [ $action == "4" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo "::::::::: Export ZFS pool :::::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS pool list >>"
	echo "$pool_list"
	echo ""
	echo -n "Select pool (enter pool name): " && read pool
	sudo zpool export $pool
fi
if [ $action == "5" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo "::::::::: Destroy ZFS pool ::::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS pool list >>"
	echo "$pool_list"
	echo ""
	echo -n "Select pool (enter pool name): " && read pool
	sudo zpool destroy $pool
fi
if [ $action == "6" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo "::::::: List of ZFS pool(s) :::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "$pool_list"
	echo ""
fi
if [ $action == "7" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo ":::::: List of ZFS dataset(s) :::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS dataset list >>"
	echo "$dataset_list"
	echo ""
fi
if [ $action == "8" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo ":::::::::: Scrub ZFS pool :::::::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "$pool_list"
	echo ""
	echo -n "Select pool (enter pool name): " && read pool
	echo "scrubing $pool..." && sudo zpool scrub $pool && echo "done."
fi
if [ $action == "9" ]; then
	echo ":::::::::::::::::::::::::::::::::::"
	echo ":::::: Destroy ZFS dataset(s) :::::"
	echo ":::::::::::::::::::::::::::::::::::"
	echo ""
	echo "<< ZFS dataset list >>"
	echo "$dataset_list"
	echo ""
	echo -n "Select dataset (enter dataset name): " && read dataset
	sudo zfs destroy $dataset
fi
if [ $action == "0" ]; then
	clear && exit 0;
fi
exit 0;
