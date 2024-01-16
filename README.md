If you want to RUN the information collection for ONE ACCOUNT onto a SINGLE REGION:
  1)  Execute the command "launch_scripts.sh <region-anme>".
      This will gather the account, you must have your bash configured, and aws-cli installed.
      Be sure jq and tee are in your PATH.
  2)  You will get the files with the format <account-id>_<region>_<topic>_info.txt
  
  Execute the script as follows, for example:
    ./launch_scripts eu-west-1

If you want to RUN the information collection for ONE ACCOUNT onto MULTIPLE REGIONS:
  1) Edit the file regions.txt and define the regions where you want to collect the information.
  2) Ensure the regions names are valid, and como separated witout any spaces.
     Ex:   us-west-1,eu-west-1,eu-west-2
  3) Execute the command ./multi_region.sh
  4) You will get the files with the format <account-id>_<region>_<topic>_info.txt for EACH of the Regions.

    Execute the script as follows, for example:
    ./multi_region.sh

  