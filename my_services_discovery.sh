#!/bin/bash

# Specify the AWS region
AWS_REGION=$1

# Specify the output file
CSV_FILE=$2

# Get the start and end dates for the last month
START_DATE_LAST_MONTH=$(date -d "$(date '+%Y-%m-01' -d '1 month ago')" '+%Y-%m-%d')
END_DATE_LAST_MONTH=$(date -d "$START_DATE_LAST_MONTH +1 month -1 day" '+%Y-%m-%d')

# Get the start and end dates for the last 3 months
START_DATE_LAST_3_MONTHS=$(date -d "$(date '+%Y-%m-01' -d '3 months ago')" '+%Y-%m-%d')
END_DATE_LAST_3_MONTHS=$(date -d "$START_DATE_LAST_3_MONTHS +3 months -1 day" '+%Y-%m-%d')

# AWS CLI command to get the cost and usage report for the last month
aws ce get-cost-and-usage \
    --region $AWS_REGION \
    --time-period Start=$START_DATE_LAST_MONTH,End=$END_DATE_LAST_MONTH \
    --granularity MONTHLY \
    --metrics "BlendedCost" "UnblendedCost" "UsageQuantity" \
    --output json | \
    jq -r '["StartDate", "EndDate", "Service", "BlendedCost", "UnblendedCost", "UsageQuantity"], (.ResultsByTime[] | [.TimePeriod.Start, .TimePeriod.End, .Groups[0].Keys[0], .Groups[0].Metrics.BlendedCost.Amount, .Groups[0].Metrics.UnblendedCost.Amount, .Groups[0].Metrics.UsageQuantity.Amount]) | @csv' > "$CSV_FILE"

# AWS CLI command to get the cost and usage report for the last 3 months
aws ce get-cost-and-usage \
    --region $AWS_REGION \
    --time-period Start=$START_DATE_LAST_3_MONTHS,End=$END_DATE_LAST_3_MONTHS \
    --granularity MONTHLY \
    --metrics "BlendedCost" "UnblendedCost" "UsageQuantity" \
    --output json | \
    jq -r '["StartDate", "EndDate", "Service", "BlendedCost", "UnblendedCost", "UsageQuantity"], (.ResultsByTime[] | [.TimePeriod.Start, .TimePeriod.End, .Groups[0].Keys[0], .Groups[0].Metrics.BlendedCost.Amount, .Groups[0].Metrics.UnblendedCost.Amount, .Groups[0].Metrics.UsageQuantity.Amount]) | @csv' >> "$CSV_FILE"

echo "CSV file generated: $CSV_FILE"

