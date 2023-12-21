#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please provide the input file as an argument."
    exit 1
fi

# Input file
input_file=$1

# Get the directory of the input file
input_dir=$(dirname "$input_file")

# Output file in the same directory as the input file
output_file="$input_dir/output.txt"

# Start of the JSON structure
echo "{" > $output_file
echo "\"boxes\" : [" >> $output_file

# Get the total number of lines in the input file
total_lines=$(wc -l < "$input_file")
current_line=0

# ID counter
id_counter=100

# Create the send object
echo "  {" >> $output_file
echo "    \"box\" : {" >> $output_file
echo "      \"maxclass\" : \"newobj\"," >> $output_file
echo "      \"text\" : \"send ---vst1\"," >> $output_file
echo "      \"id\" : \"obj-$id_counter\"," >> $output_file
echo "      \"numinlets\" : 1," >> $output_file
echo "      \"patching_rect\" : [ 260.464424052238485, 108.368140158653262, 55.0, 20.0 ]," >> $output_file
echo "      \"numoutlets\" : 0" >> $output_file
echo "    }" >> $output_file
echo "  }," >> $output_file

# Increment the ID counter
((id_counter++))

# Read the input file line by line
while IFS= read -r line
do
  # Increment the current line counter
  ((current_line++))

  # Generate the JSON structure for each line and append it to the output file
  echo "  {" >> $output_file
  echo "    \"box\" : {" >> $output_file
  echo "      \"maxclass\" : \"newobj\"," >> $output_file
  echo "      \"text\" : \"prepend \\\"$line\\\"\"," >> $output_file
  echo "      \"id\" : \"obj-$id_counter\"," >> $output_file
  echo "      \"outlettype\" : [ \"\" ]," >> $output_file
  echo "      \"numinlets\" : 1," >> $output_file
  echo "      \"patching_rect\" : [ 260.464424052238485, 88.368140158653262, 107.0, 20.0 ]," >> $output_file
  echo "      \"numoutlets\" : 1" >> $output_file
  echo "    }" >> $output_file

  # Add a comma only if the current line is not the last line
  if [ $current_line -lt $total_lines ]
  then
    echo "  }," >> $output_file
  else
    echo "  }" >> $output_file
  fi

  # Increment the ID counter
  ((id_counter++))
done < "$input_file"

# End of the JSON structure
echo "]," >> $output_file
echo "\"lines\" : [" >> $output_file
for ((i=101;i<id_counter;i++))
do
  echo "  {" >> $output_file
  echo "    \"patchline\" : {" >> $output_file
  echo "      \"source\" : [ \"obj-$i\", 0 ]," >> $output_file
  echo "      \"destination\" : [ \"obj-100\", 0 ]" >> $output_file
  echo "    }" >> $output_file
  if [ $i -lt $((id_counter-1)) ]
  then
    echo "  }," >> $output_file
  else
    echo "  }" >> $output_file
  fi
done
echo "]," >> $output_file
echo "\"appversion\" : {" >> $output_file
echo "  \"major\" : 8," >> $output_file
echo "  \"minor\" : 5," >> $output_file
echo "  \"revision\" : 5," >> $output_file
echo "  \"architecture\" : \"x64\"," >> $output_file
echo "  \"modernui\" : 1" >> $output_file
echo "}," >> $output_file
echo "\"classnamespace\" : \"box\"" >> $output_file
echo "}" >> $output_file
