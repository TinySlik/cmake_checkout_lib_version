echo "Checkout Version Tools 0.0.1"

target_pkg="none"
target="none"

for file in `ls`
do
	if [ -d "./"$file ]
	then
		if [ "$1" = "$file" ]
		then
			target_pkg="$file"
			break
		fi
	fi
done
e_out_put=""

if [ "$target_pkg" = "none" ]
then
	echo "\nInput the right path in dir custom!\n"
else
	for file in `ls ./$target_pkg`
	do
		if [ -d "./$1/$file" ]
		then
			e_out_put="$e_out_put ${file##*$target_pkg}"
			if [ "${file##*$target_pkg}" = "$2" ]
			then
				target="/usr/local/custom/$1/$file"
			fi
		fi
	done
fi
if [ "$target" = "none" ]
then
	echo "\nThere are no $target_pkg version $2 requied\n"
	echo "$e_out_put is avaliable"
else
	e_out_put=""
	echo "\nNow clean the last version in usr/local\n"
		
	for file_i in `ls ./$target_pkg`
	do
		if [ -d "./$target_pkg/$file_i" ]
		then
			for file_j in `ls ./$target_pkg/$file_i`
			do
				if [ -d "./$target_pkg/$file_i/$file_j" ]
				then
					for file_k in `ls ./$target_pkg/$file_i/$file_j`
					do
						if [ $file_k = "cmake" ]
						then
							for file_s in `ls ./$target_pkg/$file_i/$file_j/$file_k`
							do
								echo "remove /usr/local/$file_j/cmake/$file_s"
								sudo rm /usr/local/$file_j/cmake/$file_s -rf
							done
						elif [ $file_k = "pkgconfig" ]
						then
							for file_s in `ls ./$target_pkg/$file_i/$file_j/$file_k`
                                                        do
                                                                echo "remove /usr/local/$file_j/pkgconfig/$file_s"
                                                                sudo rm /usr/local/$file_j/pkgconfig/$file_s -rf
                                                        done
						else
							echo "remove /usr/local/$file_j/$file_k"
							sudo rm /usr/local/$file_j/$file_k -rf
						fi
					done
				fi
			done
		fi
	done
	echo "\nNow link the requied version file.\n"	

	for file in `ls $target`
	do
		if [ -d "$target/$file" ]
		then
			for file_d in `ls $target/$file`
			do
				if [ $file_d = "cmake" ]
				then
					for file_e in `ls $target/$file/cmake`
					do
						echo "link $target/$file/cmake/$file_e to /usr/local/$file/cmake/$file_e"
						sudo ln -s $target/$file/cmake/$file_e  /usr/local/$file/cmake/$file_e
					done
				elif [ $file_d = "pkgconfig" ]
				then
					for file_e in `ls $target/$file/pkgconfig`
					do
						echo "link $target/$file/cmake/$file_e to /usr/local/$file/pkgconfig/$file_e"
						sudo ln -s $target/$file/pkgconfig/$file_e  /usr/local/$file/pkgconfig/$file_e
					done
				else
					if [ -d "$target/$file/$file_d" ]
					then
						echo "link $target/$file/$file_d to /usr/local/$file/$file_d"
						sudo ln -s $target/$file/$file_d /usr/local/$file/$file_d
					else
						echo "link $target/$file/$file_d to /usr/local/$file/$file_d"
						sudo ln -s $target/$file/$file_d /usr/local/$file/$file_d
					fi
				fi
			done
		fi
	done
fi

