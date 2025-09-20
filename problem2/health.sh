#!/usr/bin/env bash

CPU_THRESHOLD=80
MEM_THRESHOLD=90
DISK_THRESHOLD=90
LOG_FILE="/var/log/health.log"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
MEM_USAGE=$(free | awk '/Mem/{printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
PROCESS_COUNT=$(ps aux --no-heading | wc -l)

TIME=$(date +"%Y-%m-%d %H:%M:%S")

echo "$[TIME] CPU: ${CPU_USAGE}% | MEM: ${MEM_USAGE}% | DISK: ${DISK_USAGE}% | PROCESSES: ${PROCESS_COUNT}" >> "$LOG_FILE"

if [ "${CPU_USAGE}" -gt "${CPU_THRESHOLD}" ]; then
  echo "[${TIME}] ALERT: CPU usage high (${CPU_USAGE}%)" >> "$LOG_FILE"
fi

if [ "${MEM_USAGE}" -gt "${MEM_THRESHOLD}" ]; then
  echo "[${TIME}] ALERT: Memory usage high (${MEM_USAGE}%)" >> "$LOG_FILE"
fi

if [ "${DISK_USAGE}" -gt "${DISK_THRESHOLD}" ]; then
  echo "[${TIME}] ALERT: Disk usage high (${DISK_USAGE}%)" >> "$LOG_FILE"
fi

