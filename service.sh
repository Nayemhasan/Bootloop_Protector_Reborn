#!/system/bin/sh
#Bootloop saver by watermelon

MODDIR=${0%/*}
. "$MODDIR/utils.sh"


rm -rf /cache/bootloop_saver.log.bak
mv -f /cache/bootloop_saver.log /cache/bootloop_saver.log.bak 2>/dev/null
write_log "bootloop saver started"
MAIN_ZYGOTE_NICENAME=zygote
CPU_ABI=$(getprop ro.product.cpu.api)
[ "$CPU_ABI" = "arm64-v8a" -o "$CPU_ABI" = "x86_64" ] && MAIN_ZYGOTE_NICENAME=zygote64

check(){
TEXT1="$1"
TEXT2="$2"
result=false
for i in $TEXT1; do
    for j in $TEXT2; do
        [ "$i" == "$j" ] && result=true
    done
done
$result
}


# Wait for zygote starts
sleep 5

ZYGOTE_PID1=$(pidof "$MAIN_ZYGOTE_NICENAME")
write_log "pid of zygote stage 1: $ZYGOTE_PID1"
sleep 15
ZYGOTE_PID2=$(pidof "$MAIN_ZYGOTE_NICENAME")
write_log "pid of zygote stage 2: $ZYGOTE_PID2"
sleep 15
ZYGOTE_PID3=$(pidof "$MAIN_ZYGOTE_NICENAME")
write_log "pid of zygote stage 3: $ZYGOTE_PID3"


if check "$ZYGOTE_PID1" "$ZYGOTE_PID2" && check "$ZYGOTE_PID2" "$ZYGOTE_PID3"; then
    if [ -z "$ZYGOTE_PID1" ]; then
        write_log "maybe zygote not start :("
        write_log "zygote meets the trouble, disable all modules and restart"

        disable_modules
    else
        exit_log "pid of 3 stage zygote is the same"
    fi
else
    write_log "pid of 3 stage zygote is different, continue check to make sure... "
fi




sleep 15
ZYGOTE_PID4=$(pidof "$MAIN_ZYGOTE_NICENAME")
write_log "pid of zygote stage 4: $ZYGOTE_PID4"
check "$ZYGOTE_PID3" "$ZYGOTE_PID4" && exit_log "pid of zygote stage 3 and 4 is the same."

write_log "zygote meets the trouble, disable all modules and restart"

disable_modules

