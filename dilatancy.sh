# Script file to run the dilatancy calculations
#------------------- for cyclic shear ---------------
# : <<COMMENT

rm dilatancyStrobs
g++ -O3 -std=c++11 dilatancyModulusStroboscopicConfigs.cpp -o dilatancyStrobs

# parent_dir=/Data6/krishnaData6/constPressYieldYukti/cyclicShear/Eis7.05N4kRho1.2/set5/maxg0.12/restartFiles
# parent_dir="/Data6/krishnaData6/constPressYieldYukti/cyclicShear/Eis6.92N4kRho1.2/set1/maxg0.12/restartFiles"
parent_dir="/Data6/krishnaData6/constPressYieldYukti/cyclicShear/P0Eis7.05N4kRho1.2/set5/maxg0.12/restartFiles"

#parent_dir="/Data6/krishnaData6/constPressYieldYukti/uniformShear/Eis7.05N4kRho1.2/set1/maxg2/restartFiles"

restartDir=${parent_dir}
icyc=1
fcyc=$(ls ${restartDir} | grep -oP 'restart.\K\d+' | sort -n | tail -1)
echo "fcycle: ${fcyc}"


for cyc in $(seq ${icyc} ${fcyc}); do
    fileId=${cyc}
    fileName=restart.${fileId}    

    file_path="${parent_dir}/${fileName}"
    save_dir="${parent_dir}/dilatancyModulus.dat"

    ./dilatancyStrobs ${file_path} ${save_dir} ${fileName} ${fileId}
done 
# COMMENT

#------------------- for uniform shear ---------------

: <<COMMENT

g++ -O3 -std=c++11 dilatancyModulusShearedConfigs.cpp -o dilatancySheared

parent_dir="/Data6/krishnaData6/constPressYieldYukti/uniformShear/Eis7.05N4kRho1.2/set1/maxg2/cycle1"

for step in {1..10000..1}; do 
    gamma=$( echo "0.0002 * ${step}" | bc )
    rawId=$(echo "$gamma * 10000" | bc)
    gammaId=${rawId%.*} # Removes everything after the decimal

    fileName=shearedConfig_P0RedGamma${gammaId}
    file_path="${parent_dir}/${fileName}"
    save_dir="${parent_dir}/dilatancyModulus.dat"

    ./dilatancySheared ${file_path} ${save_dir} ${fileName}
done
COMMENT