############ For each region, this script will save the EC2 metadata in json format ############

# All regions will be fetched and stored in the $regions variable

$regions = aws ec2 describe-regions --all-regions --query "Regions[].{Name:RegionName}" --output text

# In the next step, will iterate with respect to each region and save the metadata in the region.json file at the given location.

foreach ($region in $regions) {

    #Please enter the local path where the output file will be saved
    $path= "C:\Users\Rkeshari\Documents\EC2_data\$region.json"

    Write-Host "EC2 details in Json format for region $region saving at $path "
    
    #  This command will retrieve all EC2 metadata per region.
    aws ec2 describe-instances --region=$region --query 'Reservations[*].Instances[*]' --output json | out-File $path

}