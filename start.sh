#!/bin/bash

NMC_VERSION=1.0

if [ -z $BTC_PAYMENT_ADDRESS ]; then 
  echo
  echo ">>> No BTC_PAYMENT_ADDRESS specified, mining for the container author..."  
  BTC_PAYMENT_ADDRESS=3FnVBg4zFyJkRGmjuFg9sk5fAY7i6pdJXm
fi 

[ -z $BTC_THREADS ] && BTC_THREADS=4
[ -z $BTC_WORKER_ID ] && BTC_WORKER_ID=`hostname`
[ -z $BTC_SERVER ] && BTC_SERVER=equihash.usa.nicehash.com:3357

echo
echo "****************************************************"
echo "NiceHash Container Mining Agent"
echo "****************************************************"
echo "Version: ${NMC_VERSION}"
echo "Address: ${BTC_PAYMENT_ADDRESS}"
echo "Server: ${BTC_SERVER}"
echo "WorkerID: ${BTC_WORKER_ID}"
echo "****************************************************"
echo "Threads: ${BTC_THREADS}"
echo
echo "Compiling for current host processor..."
cd /root/nheqminer/cpu_xenoncat/Linux/asm/
sh assemble.sh 
cd ../../../Linux_cmake/nheqminer_cpu 
cmake . 
make

echo
echo "****************************************************"
echo "Mining..."
echo "****************************************************"
/root/nheqminer/Linux_cmake/nheqminer_cpu/nheqminer_cpu -l $BTC_SERVER -u $BTC_PAYMENT_ADDRESS.$BTC_WORKER_ID -t $BTC_THREADS